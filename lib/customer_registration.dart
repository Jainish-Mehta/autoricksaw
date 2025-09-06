import 'package:autoricksaw/customer_home_page.dart';
import 'package:autoricksaw/role_selection_page.dart';
import 'package:flutter/material.dart';

class CustomerRegistrationPage extends StatelessWidget {
  const CustomerRegistrationPage({super.key});

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
            ),
          ),
          title: const Text('Customer Registration')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: 'Name')),
            TextField(decoration: InputDecoration(labelText: 'Email')),
            TextField(decoration: InputDecoration(labelText: 'Phone')),
            ElevatedButton(
                onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => CustomerHomePage()),
                    ),
                child: Text('Register'))
          ],
        ),
      ),
    );
  }
}
