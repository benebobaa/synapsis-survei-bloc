

import 'package:flutter/material.dart';

class CustomSnackbar {
  static void showMessage(String message, context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}