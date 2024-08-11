import 'package:flutter/material.dart';
// import 'package:machine_test/mainscreen.dart';
import 'package:machine_test/provider/changescreen.dart';
// import 'package:machine_test/screens/loginpage/login_page.dart';
// import 'package:machine_test/screens/loginpage/otp_verification.dart';
// import 'package:machine_test/screens/registrationpage/registration.dart';
import 'package:machine_test/screens/splash/splash_screen.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainScreenNotifier()),
        // Add other providers here
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
