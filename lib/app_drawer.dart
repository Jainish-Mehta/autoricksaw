// lib/widgets/app_drawer.dart
import 'package:autoricksaw/driver_profile.dart';
import 'package:autoricksaw/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'customer_profile.dart';

class AppDrawer extends StatelessWidget {
  final String userType;
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
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 254, 187, 38),
                ),
                child: Row(
                  children: [
                    Icon(Icons.person, color: Colors.black, size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '$userType: $userName',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      ),
                    ),
                  ],
                )),
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.black),
            title: Text('Profile',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            onTap: () async {
              //final prefs = await SharedPreferences.getInstance();
              //final type= prefs.getString('usertype')??'';

              if (userType.toLowerCase() == 'driver') {
                if (!context.mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => DriverProfile()),
                );
              } else if (userType.toLowerCase() == 'customer') {
                if (!context.mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => CustomerProfile()),
                );
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.black),
            title: Text('Settings',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
          ),
          Spacer(),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.black),
            title: Text('Logout',
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold)),
            onTap: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              if (!context.mounted) return;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
