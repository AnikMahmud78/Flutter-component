// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/special_requirements_card.dart';
import 'widgets/field_capture_accuracy_banner.dart';

void main() {
  runApp(const SpecialRequirementsScreenApp());
}

class SpecialRequirementsScreenApp extends StatelessWidget {
  const SpecialRequirementsScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Special Requirements Field (GEN-01200)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const SpecialRequirementsScreen(),
    );
  }
}

class SpecialRequirementsScreen extends StatelessWidget {
  const SpecialRequirementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Special Requirements Field (GEN-01200)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            FieldCaptureAccuracyBanner(status: 'Pass', accuracy: 0.999),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SpecialRequirementsCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
