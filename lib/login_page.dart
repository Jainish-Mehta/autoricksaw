import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:autoricksaw/customer_home_page.dart';
import 'package:autoricksaw/driver_home_page.dart';
import 'package:autoricksaw/registration.dart';

class LoginPage extends StatefulWidget {
  final String? selectedRole;
  const LoginPage({super.key, this.selectedRole});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String selectedRole;

  @override
  void initState() {
    super.initState();
    selectedRole = widget.selectedRole ?? 'customer';
  }

  final String customerLoginID = 'customer@gmail.com';
  final String driverLoginID = 'driver@gmail.com';
  final String password = '12341234';

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
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRoleCard(
                  role: 'customer',
                  icon: Icons.person,
                  label: 'Customer',
                ),
                const SizedBox(width: 32),
                _buildRoleCard(
                  role: 'driver',
                  icon: Icons.local_taxi,
                  label: 'Driver',
                ),
              ],
            ),
            const SizedBox(height: 32),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  TextField(
                    controller: _controllerEmail,
                    decoration: InputDecoration(
                      label: Text(
                        'Email',
                        style: TextStyle(color: Colors.deepPurple),
                      ),
                      prefixIcon: Icon(Icons.email, color: Colors.deepPurple),
                    ),
                  ),
                  SizedBox(height: 5),
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
                      prefixIcon: Icon(Icons.lock, color: Colors.deepPurple),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text('No Account?'),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => RegistrationPage()),
                              );
                            },
                            child: const Text(
                              ' Signup',
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final email = _controllerEmail.text;
                          final pass = _controllerPassword.text;

                          if ((selectedRole == 'customer' &&
                                  email == customerLoginID &&
                                  pass == password) ||
                              (selectedRole == 'driver' &&
                                  email == driverLoginID &&
                                  pass == password)) {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('isLoggedIn', true);
                            await prefs.setString('userType', selectedRole);

                            if (!mounted) return;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => selectedRole == 'customer'
                                    ? CustomerHomePage()
                                    : DriverHomePage(),
                              ),
                            );
                          } else {
                            if (!mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Invalid credentials'),
                                backgroundColor: Colors.red,
                              ),
                            );
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
