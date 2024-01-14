import 'package:flutter_modular/flutter_modular.dart';
import '../../auth/domain/auth_controller.dart';

class HomeController {
  final _authController = Modular.get<AuthController>();

  Future<void> logout() async {
    await _authController.signOut();
    Modular.to.navigate('/'); // Navigate to the login screen after logout.
  }

  // Add any other home-specific logic here.
}
