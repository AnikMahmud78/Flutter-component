// lib/main.dart
// Task GEN-00125: Prerequisite Steps 9 and 10 Verification Gate
import 'package:flutter/material.dart';
import 'widgets/steps_9_10_gate_card.dart';
import 'widgets/itil_prereq_9_10_banner.dart';

void main() {
  runApp(const Steps910GateApp());
}

class Steps910GateApp extends StatelessWidget {
  const Steps910GateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prerequisite Gate 9 & 10',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Gate910Screen(),
    );
  }
}

class Gate910Screen extends StatelessWidget {
  const Gate910Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prerequisite Gate (GEN-00125)')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ItilPrereq910Banner(status: 'Pass'),
            Steps910GateCard(),
          ],
        ),
      ),
    );
  }
}
