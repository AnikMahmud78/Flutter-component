// lib/main.dart
// Task GEN-00148: Prerequisite Step 16 Verification Gate
import 'package:flutter/material.dart';
import 'widgets/step_16_gate_card.dart';
import 'widgets/step_16_prereq_banner.dart';

void main() {
  runApp(const Step16GateApp());
}

class Step16GateApp extends StatelessWidget {
  const Step16GateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Step 16 Prerequisite Gate',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const Gate16Screen(),
    );
  }
}

class Gate16Screen extends StatelessWidget {
  const Gate16Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Step 16 Gate (GEN-00148)')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Step16PrereqBanner(status: 'Pass'),
            Step16GateCard(),
          ],
        ),
      ),
    );
  }
}
