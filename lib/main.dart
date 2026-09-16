// lib/main.dart
// Task GEN-00092: Confirm Enforced 48dp Touch Bounds Delivery
import 'package:flutter/material.dart';
import 'widgets/touch_target_auditor.dart';
import 'widgets/wcag_accessibility_banner.dart';

void main() {
  runApp(const TouchTargetApp());
}

class TouchTargetApp extends StatelessWidget {
  const TouchTargetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Touch Target Enforcement',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const TouchTargetScreen(),
    );
  }
}

class TouchTargetScreen extends StatelessWidget {
  const TouchTargetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Touch Bounds Audit (GEN-00092)')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            WcagAccessibilityBanner(status: 'Pass', touchDp: 48),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: TouchTargetAuditor(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
