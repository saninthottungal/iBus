import 'package:flutter/material.dart';

class SnaackBar {
  static void showSnaackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: color,
        content: Text("🚍 $message"),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
