import 'dart:convert'; // Import for JSON encoding
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import for HTTP requests
import 'package:machine_test/screens/homepage/home_page.dart';
// import 'package:machine_test/screens/loginpage/login_page.dart';

class RegistrationPage extends StatefulWidget {
  final String userId;
  const RegistrationPage({
    super.key,
    required this.userId,
  });

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _referralCodeController = TextEditingController();

  Future<void> _register() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final referralCode = _referralCodeController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email and password cannot be empty')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://devapiv4.dealsdray.com/api/v2/user/email/referral'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'referralCode': referralCode,
          'userId': widget.userId,
        }),
      );

      if (response.statusCode == 200) {
        // Registration successful
        print('Registration successful: ${response.body}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );
      } else {
        // Registration failed
        print('Failed to register');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration failed')),
        );
      }
    } catch (e) {
      print('Error occurred during registration: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error occurred during registration')),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _referralCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        onPressed: _register,
        child: const Icon(Icons.arrow_forward),
      ),
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
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
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Let's Begin!",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Please enter your credentials to proceed',
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Your Email',
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(8),
                        // ),
                        // contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        hintText: 'Create Password',
                        suffixIcon: Icon(Icons.visibility),
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(8),
                        // ),
                        // contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _referralCodeController,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        hintText: 'Referral Code (Optional)',
                        // border: OutlineInputBorder(
                        //   borderRadius: BorderRadius.circular(8),
                        // ),
                        // contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
