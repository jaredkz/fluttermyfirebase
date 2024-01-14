import 'package:flutter_modular/flutter_modular.dart';
import 'auth_controller.dart'; // Import AuthController.

class LogoutController {
  final AuthController _authController;

  const LogoutController(this._authController);

  Future<void> logout() async {
    try {
      await _authController.signOut();
      // Additional logout logic here if needed.
      Modular.to.navigate('/');
      // Navigate to the login page after logout.
    } catch (e) {
      // Handle any errors here.
      print('Logout error: $e');
    }
  }
}
