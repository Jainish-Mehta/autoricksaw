import 'package:autoricksaw/Customer/customer_home_page.dart';
import 'package:autoricksaw/Driver/driver_home_page.dart';
import 'package:autoricksaw/General/exit_pop_up.dart';
import 'package:autoricksaw/Login&Signup/registration.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  final String customerLoginID = 'Customer@1234';
  final String driverLoginID = 'Driver@1234';
  final String customerPassword = 'Customer@1234';
  final String driverPassword = 'Driver@1234';

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        await handlePopResult(context, didPop, result);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Select Account Type',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildRoleCard(
                    role: 'customer',
                    iconWidget:
                        const Icon(Icons.person, size: 48, color: Colors.black),
                    label: 'Customer',
                  ),
                  const SizedBox(width: 32),
                  _buildRoleCard(
                    role: 'driver',
                    iconWidget: Image.asset(
                      'assets/Images/Auto.png',
                      height: 48,
                      width: 48,
                    ),
                    label: 'Driver',
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextField(
                      controller: _controllerEmail,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(width: 1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        label: const Text(
                          'Email',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            backgroundColor: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        prefixIcon:
                            const Icon(Icons.email, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _controllerPassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        label: const Text(
                          'Password',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            backgroundColor: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        prefixIcon: const Icon(Icons.lock, color: Colors.black),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Text('No Account?'),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const RegistrationPage()),
                                );
                              },
                              child: const Text(
                                ' Signup',
                                style: TextStyle(
                                  color: Colors.black,
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
                                    pass == customerPassword) ||
                                (selectedRole == 'driver' &&
                                    email == driverLoginID &&
                                    pass == driverPassword)) {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool('isLoggedIn', true);
                              await prefs.setString('userType', selectedRole);

                              if (!context.mounted) return;
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (_) => selectedRole == 'customer'
                                      ? const CustomerHomePage()
                                      : const DriverHomePage(),
                                ),
                                (Route<dynamic> route) => false,
                              );
                            } else {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Invalid credentials'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 254, 187, 38),
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required String role,
    required Widget iconWidget,
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color.fromARGB(255, 254, 187, 38)
              : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? const Color.fromARGB(255, 254, 187, 38)
                : Colors.grey,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            iconWidget,
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (isSelected)
              const Padding(
                padding: EdgeInsets.only(top: 0),
                child: Icon(Icons.check_circle, color: Colors.black),
              ),
          ],
        ),
      ),
    );
  }
}
