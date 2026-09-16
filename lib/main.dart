// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/steps_9_13_gate_card.dart';
import 'widgets/itil_gating_banner.dart';

void main() {
  runApp(const Steps913App());
}

class Steps913App extends StatelessWidget {
  const Steps913App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prerequisite Gate Steps 9 & 13',
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
      appBar: AppBar(title: const Text('Prerequisite Gate (GEN-00192)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ItilGatingBanner(status: 'Pass', verificationRate: 1.0),
            Steps913GateCard(),
          ],
        ),
      ),
    );
  }
}
