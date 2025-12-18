import 'package:flutter/material.dart';

class DriverOnline extends StatefulWidget {
  const DriverOnline({super.key});

  @override
  DriverOnlineState createState() => DriverOnlineState();
}

class DriverOnlineState extends State<DriverOnline> {
  bool isOnline = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Online Status'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isOnline ? 'You are Online' : 'You are Offline',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Switch(
              value: isOnline,
              onChanged: (value) {
                setState(() {
                  isOnline = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
