import 'package:flutter/material.dart';
import 'widgets/dependency_gate_card.dart';
import 'widgets/itil_quality_banner.dart';

void main() {
  runApp(const DependencyGateApp());
}

class DependencyGateApp extends StatelessWidget {
  const DependencyGateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dependency Gating',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const DependencyScreen(),
    );
  }
}

class DependencyScreen extends StatelessWidget {
  const DependencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dependency Gating (GEN-00013)')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ItilQualityBanner(status: 'Pass'),
            DependencyGateCard(),
          ],
        ),
      ),
    );
  }
}
