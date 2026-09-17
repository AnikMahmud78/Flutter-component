// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/dwell_time_card.dart';
import 'widgets/ia_task_success_banner.dart';

void main() {
  runApp(const DwellTimeScreenApp());
}

class DwellTimeScreenApp extends StatelessWidget {
  const DwellTimeScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dwell-Time Tracking (GEN-01167)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const DwellTimeScreen(),
    );
  }
}

class DwellTimeScreen extends StatelessWidget {
  const DwellTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dwell-Time Tracking (GEN-01167)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            IaTaskSuccessBanner(status: 'Good', successRate: 0.95),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: DwellTimeCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
