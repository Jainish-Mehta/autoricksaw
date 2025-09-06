import 'package:autoricksaw/driver_home_page.dart';
import 'package:autoricksaw/role_selection_page.dart';
import 'package:flutter/material.dart';

class DriverRegistrationPage extends StatelessWidget {
  const DriverRegistrationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => RoleSelectionPage()),
              );
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.deepPurple,
            )),
        title: const Text(
          'Driver Registration',
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 20,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Name',
                hintStyle: TextStyle(
                  color: Colors.deepPurple,
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'License Number',
                hintStyle: TextStyle(
                  color: Colors.deepPurple,
                ),
              ),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Vehicle Type',
                hintStyle: TextStyle(
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DriverHomePage()),
                  ),
                  child: const Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
