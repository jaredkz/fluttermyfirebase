import 'package:flutter/material.dart';

void showLoadingIndicator(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator()),
  );
}

void hideLoadingIndicator(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  }
}

void showSnackbar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

class GlobalSnackbar {
  static void showSuccess(BuildContext context, String message) {
    _showSnackbar(context, message, Colors.green);
  }

  static void showError(BuildContext context, String message) {
    _showSnackbar(context, message, Colors.red);
  }

  static void _showSnackbar(
      BuildContext context, String message, Color backgroundColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
