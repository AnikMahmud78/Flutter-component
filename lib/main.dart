import 'package:flutter/material.dart';
import 'widgets/rapid_backtrack_tracker.dart';
import 'widgets/backtrack_quality_banner.dart';

void main() {
  runApp(const BacktrackTrackerApp());
}

class BacktrackTrackerApp extends StatelessWidget {
  const BacktrackTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rapid Backtrack Telemetry',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const BacktrackScreen(),
    );
  }
}

class BacktrackScreen extends StatelessWidget {
  const BacktrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rapid Backtrack Tracking (FLADE-006-06)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const BacktrackQualityBanner(qualityScore: 1.0, status: 'Good (100%)'),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: RapidBacktrackTracker(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
