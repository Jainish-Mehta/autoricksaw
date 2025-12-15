import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> handlePopResult(
  BuildContext context,
  bool didPop,
  Object? result, {
  String title = 'Exit App?',
  String message = 'Do you really want to close the app?',
  String confirmText = 'Exit',
  String cancelText = 'Cancel',
  VoidCallback? onConfirm,
}) async {
  if (!didPop) {
    final navigator = Navigator.of(context);
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => navigator.pop(false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => navigator.pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );

    if (shouldExit == true) {
      if (onConfirm != null) {
        onConfirm();
      } else {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else {
          navigator.maybePop();
        }
      }
    }
  }
}
