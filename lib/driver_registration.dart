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
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 500,
              width: 400,
              child: DecoratedBox(
                  decoration: BoxDecoration(color: Colors.deepPurple)),
            )
          ],
        ),
      ),
    );
  }
}
