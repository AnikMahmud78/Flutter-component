// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/mto_efficiency_card.dart';
import 'widgets/looker_load_banner.dart';

void main() {
  runApp(const MtoEfficiencyApp());
}

class MtoEfficiencyApp extends StatelessWidget {
  const MtoEfficiencyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MTO Workforce Efficiency',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const EfficiencyScreen(),
    );
  }
}

class EfficiencyScreen extends StatelessWidget {
  const EfficiencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MTO Workforce Efficiency (GEN-00845)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            LookerLoadBanner(status: 'Complete', loadTimeSecs: 0.4),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: MtoEfficiencyCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
