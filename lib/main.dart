// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/rollback_simulator_card.dart';
import 'widgets/ieee29119_test_banner.dart';

void main() {
  runApp(const RollbackSimApp());
}

class RollbackSimApp extends StatelessWidget {
  const RollbackSimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rollback Verification Simulator',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const RollbackSimScreen(),
    );
  }
}

class RollbackSimScreen extends StatelessWidget {
  const RollbackSimScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rollback Verification (GEN-00436)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Ieee29119TestBanner(status: 'Pass'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: RollbackSimulatorCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
