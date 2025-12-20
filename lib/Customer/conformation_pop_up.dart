import 'package:autoricksaw/Customer/autoricksaw_booking.dart';
import 'package:flutter/material.dart';

Future<void> handleConfirmResult(
    BuildContext context, bool didPop, Object? result,
    {required String cost,
    required String driverPhoneNo,
    required String driverName,
    required String vehicalNo,
    required String fare}) async {
  if (!didPop) {
    final navigator = Navigator.of(context);
    final shouldBook = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Book Ride?'),
        content: const Text('Do you really want to book ride?'),
        actions: [
          TextButton(
            onPressed: () => navigator.pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => navigator.pop(true),
            child: const Text('Book'),
          ),
        ],
      ),
    );
    if (!context.mounted) return;
    if (shouldBook == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AutoricksawBooking(
            cost: cost,
            driverPhoneNo: driverPhoneNo,
            driverName: driverName,
            vehicalNo: vehicalNo,
            fare: fare,
          ),
        ),
      );
    }
  }
}
