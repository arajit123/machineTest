import 'dart:async'; // Import for Timer
import 'dart:convert'; // Import for JSON encoding

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import for HTTP requests
import 'package:machine_test/screens/registrationpage/registration.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

// import 'package:machine_test/register_page.dart'; // Assuming this is your register page

class OTPVerificationScreen extends StatefulWidget {
  final String userId;
  final String deviceId;
  final String mobileNumber;
  const OTPVerificationScreen({
    super.key,
    required this.userId,
    required this.deviceId,
    required this.mobileNumber,
  });

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  late Timer _timer;
  int _start = 60; // Countdown start time in seconds
  String _otp = '';
  bool _isResending = false; // Flag to handle resend state

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  String get _timerText {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> _verifyOtp() async {
    final String responseBody = jsonEncode(<String, String>{
      'otp': _otp,
      'deviceId': widget.deviceId,
      'userId': widget.userId,
    });
    if (_otp.isEmpty || _otp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid OTP')),
      );
      return;
    }

    try {
      final response = await http.post(
          Uri.parse(
              'http://devapiv4.dealsdray.com/api/v2/user/otp/verification'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: responseBody);
      print('response body :$responseBody');
      print(response.statusCode);
      if (response.statusCode == 200) {
        // Successfully verified OTP
       
        print('OTP verification successful: ${response.body}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                RegistrationPage(userId: widget.userId,), // Replace with your register page
          ),
        );
      } else {
        // Failed to verify OTP
        print('Failed to verify OTP');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP verification failed')),
        );
      }
    } catch (e) {
      print('Error occurred while verifying OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error occurred while verifying OTP')),
      );
    }
  }

  Future<void> _resendOtp() async {
    setState(() {
      _isResending = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/otp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'mobileNumber': widget.mobileNumber,
          'deviceId': widget.deviceId,
        }),
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        // Successfully resent OTP
        print('OTP resend successful: ${response.body}');
        setState(() {
          _start = 60; // Reset timer
          _startTimer(); // Restart timer
          _isResending = false;
        });
      } else {
        // Failed to resend OTP
        print('Failed to resend OTP');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to resend OTP')),
        );
        setState(() {
          _isResending = false;
        });
      }
    } catch (e) {
      print('Error occurred while resending OTP: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error occurred while resending OTP')),
      );
      setState(() {
        _isResending = false;
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Image.asset('assets/icons/otp.png'),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text(
                  "OTP Verification",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text(
                  "We have sent a unique OTP number to your mobile +91-${widget.mobileNumber}",
                  textAlign: TextAlign.justify,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: PinCodeTextField(
                  appContext: context,
                  length: 4,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(9),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                    inactiveColor: Colors.grey,
                    activeColor: Colors.green,
                    selectedColor: Colors.grey,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _otp = value;
                    });
                    // Automatically verify OTP when it is filled
                    if (value.length == 4) {
                      _verifyOtp();
                    }
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_timerText), // Display the countdown timer
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        disabledBackgroundColor: Colors.white,
                      ),
                      onPressed: _start == 0 && !_isResending
                          ? () {
                              _resendOtp();
                            }
                          : null,
                      child: GestureDetector(
                        onTap: () {
                          if (_start == 0 && !_isResending) {
                            _resendOtp();
                          }
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.grey),
                            ),
                          ),
                          child: Text(
                            _isResending ? 'Resending...' : 'SEND AGAIN',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 20),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20),
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: Colors.red,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //       minimumSize: Size(double.infinity, 50),
              //     ),
              //     onPressed: _verifyOtp,
              //     child: const Text(
              //       'Verify OTP',
              //       style: TextStyle(
              //         color: Colors.white,
              //         fontWeight: FontWeight.bold,
              //         fontSize: 20,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
