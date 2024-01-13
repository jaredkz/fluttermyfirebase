import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_core/firebase_core.dart';
import 'shared/components/custom_error_widget.dart';
import 'core/app_module.dart';
import 'core/app_widget.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await initializeFirebase();

  // Set the initial route for Modular
  Modular.setInitialRoute('/');

  // Custom error widget for the entire application
  ErrorWidget.builder =
      (FlutterErrorDetails details) => CustomErrorWidget(details: details);

  // Set up Modular routing and dependencies
  runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

Future<void> initializeFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Firebase initialization error: $e");
    rethrow; // Re-throw the error to prevent the app from running
  }
}
