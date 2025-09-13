import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> handlePopResult(
    BuildContext context, bool didPop, Object? result) async {
  if (!didPop) {
    final navigator = Navigator.of(context); // cache before async
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Exit App?'),
        content: const Text('Do you really want to close the app?'),
        actions: [
          TextButton(
            onPressed: () => navigator.pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => navigator.pop(true),
            child: const Text('Exit'),
          ),
        ],
      ),
    );

    if (shouldExit == true) {
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else {
        navigator.maybePop();
      }
    }
  }
}
