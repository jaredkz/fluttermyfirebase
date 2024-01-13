import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../auth/domain/auth_controller.dart'; // Import AuthController
import '../../auth/domain/logout_controller.dart'; // Import LogoutController

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final logoutController = LogoutController(Modular.get<AuthController>());
    final currentUser = Modular.get<AuthController>().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () async {
              await logoutController.logout();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the Home Page',
                style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            if (currentUser != null) ...[
              Text('Logged in as: ${currentUser.email}',
                  style: const TextStyle(fontSize: 18)),
              Text('User ID: ${currentUser.uid}',
                  style: const TextStyle(fontSize: 16)),
            ] else
              const Text('Not logged in', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
