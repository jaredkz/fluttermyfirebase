import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:firebase_core/firebase_core.dart';
import 'shared/components/custom_error_widget.dart';
import 'core/app_module.dart';
import 'core/app_widget.dart';
import 'firebase_options.dart';
import 'package:device_preview/device_preview.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase.
  await initializeFirebase();

  // Set the initial route for Modular.
  Modular.setInitialRoute('/');

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return CustomErrorWidget(
      errorMessage: details.exceptionAsString(),
    );
  };

  runApp(
    DevicePreview(
      builder: (context) => ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ), // Wrap ModularApp with DevicePreview.
      enabled: !kReleaseMode,
    ),
  );
}

Future<void> initializeFirebase() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Firebase initialization error: $e");
    rethrow;
    // Re-throw the error to prevent the app from running.
  }
}
