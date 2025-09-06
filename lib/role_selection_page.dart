import 'package:flutter/material.dart';
import 'package:autoricksaw/customer_registration.dart';
import 'package:autoricksaw/driver_registration.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const CustomerRegistrationPage()),
              ),
              child: const Text('Register as Customer'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const DriverRegistrationPage()),
              ),
              child: const Text('Register as Driver'),
            ),
          ],
        ),
      ),
    );
  }
}
