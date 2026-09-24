import 'package:flutter/material.dart';
import 'models/hesitation_monitor_model.dart';
import 'widgets/hesitation_monitor_card.dart';

void main() {
  runApp(const HesitationMonitorApp());
}

class HesitationMonitorApp extends StatelessWidget {
  const HesitationMonitorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hesitation Telemetry Logger',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      home: const HesitationMonitorScreen(),
    );
  }
}

class HesitationMonitorScreen extends StatefulWidget {
  const HesitationMonitorScreen({Key? key}) : super(key: key);

  @override
  State<HesitationMonitorScreen> createState() => _HesitationMonitorScreenState();
}

class _HesitationMonitorScreenState extends State<HesitationMonitorScreen> {
  HesitationMonitorModel _model = const HesitationMonitorModel(
    thresholdSeconds: 5,
    detectionAccuracy: 95.0,
    isHesitationDetected: false,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Friction Telemetry Console')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            HesitationMonitorCard(
              model: _model,
              onSimulateHesitation: () {
                setState(() {
                  _model = const HesitationMonitorModel(
                    thresholdSeconds: 5,
                    detectionAccuracy: 95.0,
                    isHesitationDetected: true,
                  );
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Hesitation Event Logged to BigQuery Stream')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
