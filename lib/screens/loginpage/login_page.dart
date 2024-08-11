import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:machine_test/screens/loginpage/otp_verification.dart';

class LoginPage extends StatefulWidget {
  final String deviceid;

  const LoginPage({
    super.key,
    required this.deviceid,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendOtpRequest() async {
    final mobileNumber = _phoneController.text;
    print(mobileNumber);
    final deviceId = widget.deviceid;

    if (mobileNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your phone number')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/otp'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'mobileNumber': mobileNumber,
          'deviceId': deviceId,
        }),
      );

      if (response.statusCode == 200) {
         
        final responseData = jsonDecode(response.body);
         
        final userId = responseData['data']['userId'] ?? 'UnKnown';
        print('OTP request successful: ${responseData}');
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OTPVerificationScreen(userId: userId,deviceId: deviceId,mobileNumber: mobileNumber,),
          ),
        );
      } else {
        print('Failed to send OTP request');
      }
    } catch (e) {
      print('Error occurred while sending OTP request: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Opacity(
                    opacity: 0.5,
                    child: SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/download.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: 40,
                  width: 240,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    color: Colors.grey[300],
                  ),
                  child: TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Phone'),
                      Tab(text: 'Email'),
                    ],
                    indicator: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black54,
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildPhoneTab(),
                    _buildEmailTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Glad to See You!",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please provide your phone number',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'Phone',

                // Add additional styling if needed
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _sendOtpRequest,
                child: const Text(
                  'Send Code',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Glad to See You!",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please provide your email address',
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 20),
            const TextField(
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                hintText: 'Email',
                // Add additional styling if needed
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // Implement email tab functionality if needed
                },
                child: const Text(
                  'Send Code',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
