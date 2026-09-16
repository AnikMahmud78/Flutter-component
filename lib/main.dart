// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/failover_test_card.dart';
import 'widgets/iso22301_continuity_banner.dart';

void main() {
  runApp(const FailoverApp());
}

class FailoverApp extends StatelessWidget {
  const FailoverApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud SQL Regional Failover Test',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const FailoverScreen(),
    );
  }
}

class FailoverScreen extends StatelessWidget {
  const FailoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Regional Failover Test (GEN-00480)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Iso22301ContinuityBanner(status: 'Pass', durationSecs: 22.1),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: FailoverTestCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
