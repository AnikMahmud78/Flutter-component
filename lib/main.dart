// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/time_to_insight_card.dart';
import 'widgets/improvado_uat_banner.dart';

void main() {
  runApp(const InsightApp());
}

class InsightApp extends StatelessWidget {
  const InsightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time-to-Insight UAT',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const InsightScreen(),
    );
  }
}

class InsightScreen extends StatelessWidget {
  const InsightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Time-to-Insight UAT (GEN-00678)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ImprovadoUatBanner(status: 'Pass', timeSecs: 1.8),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: TimeToInsightCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
