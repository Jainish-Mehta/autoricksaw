import 'package:autoricksaw/customer_registration.dart';
import 'package:flutter/material.dart';

class CustomerHomePage extends StatelessWidget {
  const CustomerHomePage({super.key});
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
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      'Customer Details',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
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
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: Colors.deepPurple,
              ),
              title: Text(
                'Settings',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.deepPurple,
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.deepPurple),
              ),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => CustomerRegistrationPage()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.deepPurple),
        title: Text(
          'Customer Home Page',
          style: TextStyle(color: Colors.deepPurple),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 220, 181, 250),
      body: Center(
        child: Text(
          'Welcome To Customer Page',
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
