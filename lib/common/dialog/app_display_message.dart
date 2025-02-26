import 'package:flutter/material.dart';

class AppDisplayMessage {
  static void showMessage(BuildContext context, String message, {Color backgroundColor = Colors.black}) {
    var snackbar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static void error(BuildContext context, String message) =>
      showMessage(context, message, backgroundColor: Colors.red);

  static void success(BuildContext context, String message) =>
      showMessage(context, message, backgroundColor: Colors.green);

  static void warning(BuildContext context, String message) =>
      showMessage(context, message, backgroundColor: Colors.orangeAccent);

  static void info(BuildContext context, String message) =>
      showMessage(context, message, backgroundColor: Colors.blueAccent);
}
