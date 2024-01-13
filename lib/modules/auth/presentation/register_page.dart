import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttermyfirebase/shared/components/ui_helpers.dart';
import 'package:fluttermyfirebase/shared/components/button.dart';
import 'package:fluttermyfirebase/shared/components/textfield.dart';
import '../domain/register_controller.dart';
import 'package:fluttermyfirebase/shared/components/global_snackbar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  final _confirmPwController = TextEditingController();
  final _registerController = Modular.get<RegisterController>();

  void registerUser() async {
    if (!validateForm()) return;

    try {
      await _registerController.registerUser(
        _userNameController.text,
        _emailController.text,
        _pwController.text,
      );
      // Check if the widget is still in the tree
      if (mounted) {
        GlobalSnackbar.showSuccess(context, 'Registration successful');
        // Optionally navigate or perform other actions.
      }
    } catch (e) {
      if (mounted) {
        GlobalSnackbar.showError(
            context, 'Registration failed: ${e.toString()}');
      }
    }
  }

  bool validateForm() {
    if (_userNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _pwController.text.isEmpty ||
        _pwController.text != _confirmPwController.text) {
      showSnackbar(context, 'Please check your input fields');

      return false;
    }

    return true;
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _pwController.dispose();
    _confirmPwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 25),
                const Text('Log In', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 50),
                MyTextField(
                  controller: _userNameController,
                  hintText: "Username",
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: _emailController,
                  hintText: "Email",
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: _pwController,
                  hintText: "Password",
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                MyTextField(
                  controller: _confirmPwController,
                  hintText: "Confirm Password",
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                MyButton(text: "REGISTER", onTap: registerUser),
                const SizedBox(height: 25),
                GestureDetector(
                  child: Text(
                    "Already have an account? Login here",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () => Modular.to.navigate('/'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
