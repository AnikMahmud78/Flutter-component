// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/rollback_error_boundary.dart';
import 'widgets/process_conformance_banner.dart';

void main() {
  runApp(const RollbackApp());
}

class RollbackApp extends StatelessWidget {
  const RollbackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Rollback Engine',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const RollbackScreen(),
    );
  }
}

class RollbackScreen extends StatelessWidget {
  const RollbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('UI Rollback Engine (GEN-00203)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProcessConformanceBanner(status: 'Complete', conformanceRate: 1.0),
            RollbackErrorBoundary(),
          ],
        ),
      ),
    );
  }
}
