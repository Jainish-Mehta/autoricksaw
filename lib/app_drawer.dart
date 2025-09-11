// lib/widgets/app_drawer.dart
import 'package:autoricksaw/driver_profile.dart';
import 'package:autoricksaw/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppDrawer extends StatelessWidget {
  final String userType; // 'Driver' or 'Customer'
  final String userName;

  const AppDrawer({required this.userType, required this.userName, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 120,
            child: DrawerHeader(
                decoration: BoxDecoration(color: Colors.deepPurple),
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.white, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      // 👈 Ensures text doesn't overflow
                      child: Text(
                        '$userType: $userName',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        overflow:
                            TextOverflow.ellipsis, // 👈 Adds "..." if too long
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                  ],
                )),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.deepPurple),
            title: Text('Profile',
                style: TextStyle(
                    color: Colors.deepPurple, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => DriverProfile()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.deepPurple),
            title: Text('Settings',
                style: TextStyle(
                    color: Colors.deepPurple, fontWeight: FontWeight.bold)),
          ),
          Spacer(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.deepPurple),
            title: Text('Logout',
                style: TextStyle(
                    color: Colors.deepPurple, fontWeight: FontWeight.bold)),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear(); // clears isLoggedIn and userType
              if (!context.mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
