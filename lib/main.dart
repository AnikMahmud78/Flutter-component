// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/lookml_dashboard_card.dart';
import 'widgets/looker_spec_banner.dart';

void main() {
  runApp(const LookmlApp());
}

class LookmlApp extends StatelessWidget {
  const LookmlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LookML Dashboard Config',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LookmlScreen(),
    );
  }
}

class LookmlScreen extends StatelessWidget {
  const LookmlScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LookML Dashboard (GEN-00667)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            LookerSpecBanner(status: 'Complete'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: LookmlDashboardCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
