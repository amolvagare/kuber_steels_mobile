import 'package:flutter/material.dart';
import 'package:kuber_steels/main.dart';

extension DialogUtils on BuildContext {

  static void showErrorDialog(String message) {
    showDialog(
      context: navigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
