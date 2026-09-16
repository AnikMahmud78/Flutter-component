// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/steps_6_8_gate_card.dart';
import 'widgets/dependency_6_8_banner.dart';

void main() {
  runApp(const Gate68App());
}

class Gate68App extends StatelessWidget {
  const Gate68App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prerequisite Gate Steps 6 & 8',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const Gate68Screen(),
    );
  }
}

class Gate68Screen extends StatelessWidget {
  const Gate68Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Prerequisite Gate (GEN-00260)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Dependency68Banner(status: 'Pass', rate: 1.0),
            Steps68GateCard(),
          ],
        ),
      ),
    );
  }
}
