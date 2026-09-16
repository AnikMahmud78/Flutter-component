// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/build_validator_runner.dart';
import 'widgets/build_gate_banner.dart';

void main() {
  runApp(const BuildValidatorApp());
}

class BuildValidatorApp extends StatelessWidget {
  const BuildValidatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Build Parameter Validator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const BuildValidatorScreen(),
    );
  }
}

class BuildValidatorScreen extends StatelessWidget {
  const BuildValidatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Build Validator (GEN-00215)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            BuildGateBanner(status: 'Complete', conformanceRate: 1.0),
            BuildValidatorRunner(),
          ],
        ),
      ),
    );
  }
}
