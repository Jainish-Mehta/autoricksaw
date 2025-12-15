import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:autoricksaw/login_page.dart';
import 'package:autoricksaw/customer_home_page.dart';
import 'package:autoricksaw/driver_home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autorickshaw Registration',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 1));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String? userType = prefs.getString('userType');

    if (!mounted) return;

    if (isLoggedIn) {
      if (userType == "customer") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => CustomerHomePage()),
        );
      } else if (userType == "driver") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DriverHomePage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 254, 187, 38),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/Images/Auto.png',
                width: 100,
                height: 100,
              ),
              SizedBox(height: 20),
              Text(
                "Welcome",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              CircularProgressIndicator(
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
