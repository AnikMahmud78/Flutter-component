// lib/main.dart
// Task GEN-00114: Prerequisite Steps 5 and 6 Verification Gate
import 'package:flutter/material.dart';
import 'widgets/steps_5_6_gate_card.dart';
import 'widgets/itil_prereq_banner.dart';

void main() {
  runApp(const Steps56GateApp());
}

class Steps56GateApp extends StatelessWidget {
  const Steps56GateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prerequisite Gate 5 & 6',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const GateScreen(),
    );
  }
}

class GateScreen extends StatelessWidget {
  const GateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prerequisite Gate (GEN-00114)')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ItilPrereqBanner(status: 'Pass'),
            Steps56GateCard(),
          ],
        ),
      ),
    );
  }
}
