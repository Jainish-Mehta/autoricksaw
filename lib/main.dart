import 'package:flutter/material.dart';
import 'package:autoricksaw/role_selection_page.dart';

void main() {
  runApp(
    const MyApp(),
  ); //const is used bcoz we don't need to recreate widget or constructor every time
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
  const MyApp({super.key});

  // MaterialApp is a widget wraps your entire app and sets up the Material Design environment.
  // Think of it as the entry point that wires up theming, navigation, and localization.

  //Scaffold is a widget provides the basic visual structure for each screen.
  //It’s what gives you the app bar, drawer, floating action button, and body content.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Autorickshaw Registration',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const RoleSelectionPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
