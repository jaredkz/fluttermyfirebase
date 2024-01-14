import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:device_preview/device_preview.dart';

// The place where you set up your app-wide UI components like themes, navigation observers, localization, etc.

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      locale: DevicePreview.locale(context), // Device Preview setting
      builder: DevicePreview.appBuilder, // Device Preview setting
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      title: 'Flutter My Firebase',
      theme: ThemeData(
        // Theme customization.
        primarySwatch: Colors.lightBlue,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          // Define other text styles.
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // Additional localization delegates.
      ],
      supportedLocales: const [
        Locale('en', ''), // English.
        // Additional supported locales.
      ],
      // Other configurations.
    );
  }
}
