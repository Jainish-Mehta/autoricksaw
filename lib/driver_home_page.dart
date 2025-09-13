import 'package:autoricksaw/app_drawer.dart';
import 'package:autoricksaw/exit_pop_up.dart';
import 'package:flutter/material.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});
  @override
  DriverHomePageState createState() => DriverHomePageState();
}

class DriverHomePageState extends State<DriverHomePage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        await handlePopResult(context, didPop, result);
      },
      child: Scaffold(
        drawer: AppDrawer(userType: 'Driver', userName: 'Driver Name'),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.deepPurple),
          title: Text('Driver Home Page',
              style: TextStyle(color: Colors.deepPurple)),
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w600,
              fontSize: 18),
          unselectedLabelStyle: TextStyle(
              color: Colors.deepPurple,
              fontSize: 18,
              fontWeight: FontWeight.w600),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: 'History'),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 220, 181, 250),
        body: Center(
          child: Text('Welcome To Driver HomePage',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24)),
        ),
      ),
    );
  }
}
