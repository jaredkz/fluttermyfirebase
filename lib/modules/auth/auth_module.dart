import 'package:flutter_modular/flutter_modular.dart';
import 'domain/login_controller.dart';
import 'presentation/register_page.dart';
import 'domain/register_controller.dart';
import 'presentation/forgot_password_page.dart';
import 'presentation/login_page.dart';

class AuthModule extends Module {
  @override
  void binds(i) {
    i.add<LoginController>(LoginController.new);
    i.add<RegisterController>(RegisterController.new);
    // Add other binds as needed.
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const LoginPage());
    r.child('/register', child: (context) => const RegisterPage());
    r.child('/forgot-password', child: (context) => const ForgotPasswordPage());
    // Add other routes as needed.
  }
}
