import 'package:flutter/material.dart';
import 'widgets/form_error_focus_engine.dart';
import 'widgets/deployment_status_banner.dart';

void main() {
  runApp(const DynamicErrorApp());
}

class DynamicErrorApp extends StatelessWidget {
  const DynamicErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Error Positioning Engine',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const ErrorPositioningScreen(),
    );
  }
}

class ErrorPositioningScreen extends StatelessWidget {
  const ErrorPositioningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error Positioning Engine (FIEVR-032)')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const DeploymentStatusBanner(
              status: 'Pass',
              deploymentLevel: 'Progressive Rollback Enabled (Canary Pass)',
            ),
            const Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: FormErrorFocusEngine(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
