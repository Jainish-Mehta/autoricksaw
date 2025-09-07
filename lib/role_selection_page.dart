import 'package:autoricksaw/customer_home_page.dart';
import 'package:autoricksaw/customer_registration.dart';
import 'package:autoricksaw/driver_home_page.dart';
import 'package:autoricksaw/driver_registration.dart';
import 'package:flutter/material.dart';

class RoleSelectionPage extends StatefulWidget {
  const RoleSelectionPage({super.key});
  @override
  State<RoleSelectionPage> createState() => _RoleSelectedPage();
}

class _RoleSelectedPage extends State<RoleSelectionPage> {
  String selectedRole = 'customer';
  String customerLoginID = 'customer@gmail.com';
  String driverLoginID = 'driver@gmail.com';
  String password = '12341234';
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select Account Type',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRoleCard(
                  role: 'customer',
                  icon: Icons.person,
                  label: 'Customer',
                ),
                const SizedBox(
                  width: 32,
                ),
                _buildRoleCard(
                  role: 'driver',
                  icon: Icons.local_taxi,
                  label: 'Driver',
                ),
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            TextField(
              controller: _controllerEmail,
              decoration: InputDecoration(
                  label: Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.deepPurple,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.deepPurple,
                  )),
            ),
            SizedBox(
              height: 5,
            ),
            TextField(
              controller: _controllerPassword,
              decoration: InputDecoration(
                  label: Text(
                    'Password',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w500,
                      backgroundColor: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.deepPurple,
                  )),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No Account?'),
                GestureDetector(
                  onTap: () {
                    if (selectedRole == 'customer') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => CustomerRegistrationPage()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => DriverRegistrationPage()),
                      );
                    }
                  },
                  child: const Text(
                    ' Signup',
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 250,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (selectedRole == 'customer') {
                      if (customerLoginID == _controllerEmail.text &&
                          password == _controllerPassword.text) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => CustomerHomePage()),
                        );
                      }
                    } else {
                      if (driverLoginID == _controllerEmail.text &&
                          password == _controllerPassword.text) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => DriverHomePage()),
                        );
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                  child: Text('Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required String role,
    required IconData icon,
    required String label,
  }) {
    final isSelected = selectedRole == role;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRole = role;
        });
      },
      child: Container(
        width: 120,
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepPurple : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.deepPurple : Colors.grey,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(icon,
                size: 48, color: isSelected ? Colors.white : Colors.black),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isSelected)
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Icon(Icons.check_circle, color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
