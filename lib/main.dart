// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/touch_filter_controls_card.dart';
import 'widgets/filter_latency_banner.dart';

void main() {
  runApp(const TouchFilterControlsScreenApp());
}

class TouchFilterControlsScreenApp extends StatelessWidget {
  const TouchFilterControlsScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Touch Filter Controls (GEN-01134)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const TouchFilterControlsScreen(),
    );
  }
}

class TouchFilterControlsScreen extends StatelessWidget {
  const TouchFilterControlsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Touch Filter Controls (GEN-01134)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            FilterLatencyBanner(status: 'Good', latency: '<300ms'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: TouchFilterControlsCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
