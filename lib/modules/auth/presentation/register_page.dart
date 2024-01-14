import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttermyfirebase/shared/components/ui_utils.dart';
import 'package:fluttermyfirebase/shared/components/button.dart';
import 'package:fluttermyfirebase/shared/components/global_textfield.dart';
import '../domain/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _pwController = TextEditingController();
  final _confirmPwController = TextEditingController();
  final _registerController = Modular.get<RegisterController>();

  void registerUser() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _registerController.registerUser(
          _userNameController.text,
          _emailController.text,
          _pwController.text,
        );
        if (mounted) {
          GlobalSnackbar.showSuccess(context, 'Registration successful');
        }
      } catch (e) {
        if (mounted) {
          GlobalSnackbar.showError(
            context,
            'Registration failed: ${e.toString()}',
          );
        }
      }
    }
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
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),
                  const Text('Log In', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 50),
                  GlobalTextField(
                    controller: _userNameController,
                    hintText: "Name",
                  ),
                  const SizedBox(height: 10),
                  GlobalTextField(
                    controller: _emailController,
                    hintText: "Email",
                    validator: GlobalTextField.validEmail(),
                  ),
                  const SizedBox(height: 10),
                  GlobalTextField(
                    controller: _pwController,
                    hintText: "Password",
                    obscureText: true,
                    validator: GlobalTextField.validPassword(),
                  ),
                  const SizedBox(height: 10),
                  GlobalTextField(
                    controller: _confirmPwController,
                    hintText: "Confirm Password",
                    obscureText: true,
                    validator: GlobalTextField.comparePasswords(_pwController),
                  ),
                  const SizedBox(height: 25),
                  MyButton(onTap: registerUser, text: "REGISTER"),
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
      ),
    );
  }
}
