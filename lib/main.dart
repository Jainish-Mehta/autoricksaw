import 'package:autoricksaw/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:autoricksaw/customer_home_page.dart';
import 'package:autoricksaw/driver_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  String? userType = prefs.getString('userType');

  runApp(MyApp(isLoggedIn: isLoggedIn, userType: userType));
}

// StatelessWidget: Immutable, ideal for static UI
// StatefulWidget: Mutable, use when UI changes dynamically
// InheritedWidget: Used for propagating data down the widget tree efficiently

/*
 Design:
 1.Material Design provided by Google for Android
 2.Cupertino Design provided by Apple for IOS
  */
class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final String? userType;

  const MyApp({super.key, required this.isLoggedIn, this.userType});

  // MaterialApp is a widget wraps your entire app and sets up the Material Design environment.
  // Think of it as the entry point that wires up theming, navigation, and localization.

  // Scaffold is a widget provides the basic visual structure for each screen.
  // It’s what gives you the app bar, drawer, floating action button, and body content.

  @override
  Widget build(BuildContext context) {
    Widget initialScreen;

    if (isLoggedIn) {
      if (userType == 'customer') {
        initialScreen = CustomerHomePage();
      } else if (userType == 'driver') {
        initialScreen = DriverHomePage();
      } else {
        initialScreen = LoginPage(); // fallback
      }
    } else {
      initialScreen = LoginPage();
    }

    return MaterialApp(
      title: 'Autorickshaw Registration',
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: initialScreen,
      debugShowCheckedModeBanner: false,
    );
  }
}
