import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String? message;
  final FlutterErrorDetails? details;
  final VoidCallback? onRetry;

  const CustomErrorWidget({
    super.key,
    this.message,
    this.details,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final displayMessage = message ?? 'Error: ${details?.exceptionAsString()}';
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(displayMessage,
                  style: const TextStyle(fontSize: 18, color: Colors.red)),
              const SizedBox(height: 20),
              if (onRetry != null)
                ElevatedButton(
                  onPressed: onRetry,
                  child: const Text('Try Again'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
