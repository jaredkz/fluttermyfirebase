import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../shared/components/ui_utils.dart';
import '../../../shared/components/global_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // Add a form key.

  void _onResetButtonPressed() async {
    await resetPassword();
  }

  Future<void> resetPassword() async {
    if (_formKey.currentState!.validate()) {
      // Use form validation.
      showLoadingIndicator(context);
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text);
        hideLoadingIndicator(context);
        showSnackbar(context, 'Password reset link sent! Check your email.');
      } on FirebaseAuthException catch (e) {
        hideLoadingIndicator(context);
        showSnackbar(context, 'Error: ${e.message}');
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Modular.to.navigate('/'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              GlobalTextField(
                controller: emailController,
                hintText: 'Email',
                validator: GlobalTextField.validEmail(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _onResetButtonPressed, // Use the extracted method
                child: const Text('Send Password Reset Link'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
