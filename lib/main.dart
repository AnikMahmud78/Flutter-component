// lib/main.dart
// Task GEN-00068: Schema-Driven Input Mask Props for Date Types
import 'package:flutter/material.dart';
import 'widgets/date_masked_text_field.dart';
import 'widgets/validation_quality_banner.dart';

void main() {
  runApp(const DateMaskApp());
}

class DateMaskApp extends StatelessWidget {
  const DateMaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Date Mask Field Component',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const DateMaskScreen(),
    );
  }
}

class DateMaskScreen extends StatelessWidget {
  const DateMaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Date Mask Props (GEN-00068)')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ValidationQualityBanner(status: 'Pass', enforcementRate: 1.0),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: DateMaskedTextField(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
