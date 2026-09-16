// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/mtti_filter_card.dart';
import 'widgets/clean_code_mtti_banner.dart';

void main() {
  runApp(const MttiApp());
}

class MttiApp extends StatelessWidget {
  const MttiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MTTI Validation Middleware',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MttiScreen(),
    );
  }
}

class MttiScreen extends StatelessWidget {
  const MttiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MTTI IVT Filter (GEN-00734)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CleanCodeMttiBanner(status: 'Complete', executionMs: 0.8),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: MttiFilterCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
