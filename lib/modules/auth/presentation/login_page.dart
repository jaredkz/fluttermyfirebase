import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttermyfirebase/shared/components/ui_utils.dart';
import 'package:fluttermyfirebase/shared/components/button.dart';
import 'package:fluttermyfirebase/shared/components/global_textfield.dart';
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
  final loginController = LoginController();
  final _formKey = GlobalKey<FormState>();
  // Form key.
  void login() async {
    if (_formKey.currentState!.validate()) {
      showLoadingIndicator(context);
      try {
        await loginController.login(
          emailController.text,
          passwordController.text,
        );
      } catch (e) {
        hideLoadingIndicator(context);
        showSnackbar(context, e.toString());
      } finally {
        hideLoadingIndicator(context);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GlobalTextField(
                controller: emailController,
                hintText: 'Email',
                validator: GlobalTextField.validEmail(),
              ),
              const SizedBox(height: 10),
              GlobalTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
                validator: GlobalTextField.validPassword(),
              ),
              const SizedBox(height: 20),
              MyButton(onTap: login, text: 'Login'),
              const SizedBox(height: 20),
              GestureDetector(
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
                onTap: () => Modular.to.navigate('/forgot-password'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: GestureDetector(
                  // Navigate to RegisterPage.
                  child: Text(
                    'Not registered? Register here.',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () => Modular.to.navigate('/register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
