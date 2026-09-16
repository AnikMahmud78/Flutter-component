// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/outlier_cleanse_card.dart';
import 'widgets/iso25012_cleanse_banner.dart';

void main() {
  runApp(const OutlierCleanseApp());
}

class OutlierCleanseApp extends StatelessWidget {
  const OutlierCleanseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Predictive CLV Data Cleanse',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const CleanseScreen(),
    );
  }
}

class CleanseScreen extends StatelessWidget {
  const CleanseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Outlier Cleanse (GEN-00789)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Iso25012CleanseBanner(status: 'Pass'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: OutlierCleanseCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
