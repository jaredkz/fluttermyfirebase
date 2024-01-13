import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttermyfirebase/shared/components/ui_helpers.dart';
import 'package:fluttermyfirebase/shared/components/button.dart';
import 'package:fluttermyfirebase/shared/components/textfield.dart';
import '../domain/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.onTap});
  final void Function()? onTap;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final LoginController loginController = LoginController();

  void login() async {
    if (!validateForm()) return;

    showLoadingIndicator(context);
    try {
      await loginController.login(
          emailController.text, passwordController.text);
    } catch (e) {
      hideLoadingIndicator(context);
      showSnackbar(context, e.toString());
    } finally {
      hideLoadingIndicator(context);
    }
  }

  void navigateToForgotPassword() {
    Modular.to.navigate('/forgot-password');
  }

  bool validateForm() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showSnackbar(context, 'Please fill in all fields');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false),
            const SizedBox(height: 10),
            MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true),
            const SizedBox(height: 20),
            MyButton(text: 'Login', onTap: login),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: navigateToForgotPassword,
              child: const Text('Forgot Password?',
                  style: TextStyle(decoration: TextDecoration.underline)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: GestureDetector(
                onTap: () => Modular.to
                    .navigate('/register'), // Navigate to RegisterPage
                child: Text(
                  'Not registered? Register here.',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
