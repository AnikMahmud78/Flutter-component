import 'package:flutter/material.dart';
import 'widgets/device_test_runner.dart';
import 'widgets/test_quality_banner.dart';

void main() {
  runApp(const DeviceTestApp());
}

class DeviceTestApp extends StatelessWidget {
  const DeviceTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Physical Device Testing',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const DeviceTestScreen(),
    );
  }
}

class DeviceTestScreen extends StatelessWidget {
  const DeviceTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Interactive Device Testing (FLADE-006-13)')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TestQualityBanner(status: 'Good (100%)', qualityScore: 1.0),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: DeviceTestRunner(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
