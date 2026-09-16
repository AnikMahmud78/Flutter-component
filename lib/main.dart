// lib/main.dart
// Task GEN-00136: Error Payload Schema Standardization Engine
import 'package:flutter/material.dart';
import 'widgets/standardized_error_card.dart';
import 'widgets/operational_error_banner.dart';

void main() {
  runApp(const ErrorSchemaApp());
}

class ErrorSchemaApp extends StatelessWidget {
  const ErrorSchemaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Standardized Error Schema',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const ErrorSchemaScreen(),
    );
  }
}

class ErrorSchemaScreen extends StatelessWidget {
  const ErrorSchemaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error Schema Standard (GEN-00136)')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            OperationalErrorBanner(status: 'Complete'),
            StandardizedErrorCard(),
          ],
        ),
      ),
    );
  }
}
