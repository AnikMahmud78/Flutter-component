import 'package:flutter/material.dart';
import 'services/snackbar_service.dart';

void main() => runApp(const SnackbarApp());

class SnackbarApp extends StatelessWidget {
  const SnackbarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.red)),
      home: Scaffold(
        appBar: AppBar(title: const Text('Snackbar Alert Demo')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () => SnackbarService.showAccessDenied(context),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100),
                  child: const Text('Trigger "Access Denied"'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () => SnackbarService.showError(context, errorMessage: 'Network Handshake Timeout'),
                  child: const Text('Trigger Generic "Error"'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
