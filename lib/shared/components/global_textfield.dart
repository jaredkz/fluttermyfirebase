import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class GlobalTextField extends StatelessWidget {
  const GlobalTextField({
    required this.controller,
    required this.hintText,
    super.key,
    this.obscureText = false,
    this.validator,
  });

  // Static method for email validation.
  static String? Function(String?) validEmail() {
    return Validatorless.multiple([
      Validatorless.required('Email is required'),
      Validatorless.email('Enter a valid email'),
    ]);
  }

  // Static method for password validation.
  static String? Function(String?) validPassword() {
    return Validatorless.multiple([
      Validatorless.required('Password is required'),
      Validatorless.min(6, 'Password must be at least 6 characters long'),
      Validatorless.max(30, 'Password must not exceed 30 characters'),
    ]);
  }

  // Method for comparing two passwords.
  static String? Function(String?) comparePasswords(
    TextEditingController otherController,
  ) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Password is required';
      }
      if (value != otherController.text) {
        return 'Passwords do not match';
      }

      return null;
    };
  }

  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }
}
