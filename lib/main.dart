import 'package:flutter/material.dart';
import 'widgets/alert_micro_animator.dart';
import 'models/alert_payload.dart';

void main() {
  runApp(const AlertAnimApp());
}

class AlertAnimApp extends StatefulWidget {
  const AlertAnimApp({Key? key}) : super(key: key);

  @override
  State<AlertAnimApp> createState() => _AlertAnimAppState();
}

class _AlertAnimAppState extends State<AlertAnimApp> {
  AlertPayload _currentAlert = AlertPayload(alertId: 'A-1', message: 'System Nominal', severity: 'LOW');

  void _fireNewAlert() {
    setState(() {
      _currentAlert = AlertPayload(
        alertId: 'A-${DateTime.now().millisecondsSinceEpoch}',
        message: 'HIGH LATENCY SPIKE DETECTED',
        severity: 'CRITICAL',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.red),
      home: Scaffold(
        appBar: AppBar(title: const Text('Alert Micro-Animation Console')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              AlertMicroAnimator(alert: _currentAlert),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _fireNewAlert,
                child: const Text('FIRE INCOMING ALERT UPDATE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
