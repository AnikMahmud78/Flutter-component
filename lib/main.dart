// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/steps_11_27_gate_card.dart';
import 'widgets/dependency_11_27_banner.dart';

void main() {
  runApp(const Gate1127App());
}

class Gate1127App extends StatelessWidget {
  const Gate1127App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prerequisite Gate Steps 11 & 27',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const Gate1127Screen(),
    );
  }
}

class Gate1127Screen extends StatelessWidget {
  const Gate1127Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prerequisite Gate (GEN-00226)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Dependency1127Banner(status: 'Pass', rate: 1.0),
            Steps1127GateCard(),
          ],
        ),
      ),
    );
  }
}
