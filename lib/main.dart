// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/anomaly_detector_card.dart';
import 'widgets/ieee29119_speed_banner.dart';

void main() {
  runApp(const AnomalyApp());
}

class AnomalyApp extends StatelessWidget {
  const AnomalyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Marketing Anomaly Detection',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const AnomalyScreen(),
    );
  }
}

class AnomalyScreen extends StatelessWidget {
  const AnomalyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Governance (GEN-00689)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Ieee29119SpeedBanner(status: 'Pass', detectionMins: 12),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: AnomalyDetectorCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
