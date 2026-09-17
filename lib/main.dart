// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/spend_pacing_card.dart';
import 'widgets/budget_pacing_banner.dart';

void main() {
  runApp(const SpendPacingScreenApp());
}

class SpendPacingScreenApp extends StatelessWidget {
  const SpendPacingScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ad Spend Pacing Engine (GEN-00967)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const SpendPacingScreen(),
    );
  }
}

class SpendPacingScreen extends StatelessWidget {
  const SpendPacingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ad Spend Pacing Engine (GEN-00967)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            BudgetPacingBanner(status: 'Pass', alertPrecision: 100.0),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SpendPacingCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
