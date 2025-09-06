import 'package:autoricksaw/driver_home_page.dart';
import 'package:flutter/material.dart';

class DriverRegistrationPage extends StatelessWidget {
  const DriverRegistrationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Driver Registration')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Name')),
            TextField(decoration: InputDecoration(labelText: 'License Number')),
            TextField(decoration: InputDecoration(labelText: 'Vehicle Type')),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DriverHomePage()),
              ),
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
