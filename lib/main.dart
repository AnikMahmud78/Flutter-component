// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/terraform_scaling_card.dart';
import 'widgets/scaling_rule_banner.dart';

void main() {
  runApp(const ScalingApp());
}

class ScalingApp extends StatelessWidget {
  const ScalingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cloud Run Auto-Scaling Config',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const ScalingScreen(),
    );
  }
}

class ScalingScreen extends StatelessWidget {
  const ScalingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auto-Scaling Config (GEN-00901)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ScalingRuleBanner(status: 'Pass'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: TerraformScalingCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
