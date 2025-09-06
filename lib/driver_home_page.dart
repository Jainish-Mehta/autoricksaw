import 'package:autoricksaw/driver_registration.dart';
import 'package:flutter/material.dart';

class DriverHomePage extends StatelessWidget {
  const DriverHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 120,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'Driver Details',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
                leading: Icon(
                  Icons.person,
                  color: Colors.deepPurple,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold),
                )),
            ListTile(
                leading: Icon(
                  Icons.settings,
                  color: Colors.deepPurple,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold),
                )),
            const Spacer(),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.deepPurple,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                    color: Colors.deepPurple, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DriverRegistrationPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.deepPurple,
        ),
        title: Text(
          'Driver Home Page',
          style: TextStyle(
            color: Colors.deepPurple,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 220, 181, 250),
      body: Center(
        child: Text(
          'Welcome To Driver HomePage',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
