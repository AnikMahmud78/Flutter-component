import 'package:flutter/material.dart';
import 'models/anomaly_item.dart';
import 'widgets/quarantined_anomalies_dashboard.dart';

void main() => runApp(const QuarantinedDashboardApp());

class QuarantinedDashboardApp extends StatelessWidget {
  const QuarantinedDashboardApp({super.key});

  @override
  Widget build(BuildContext context) {
    final anomalies = [
      AnomalyItem(anomalyId: 'ANOM-091', severity: 'High', description: 'Out-of-bounds IBAN check attempt', detectedAt: DateTime.now()),
    ];

    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange)),
      home: Scaffold(
        appBar: AppBar(title: const Text('Quarantine Security Dashboard')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: QuarantinedAnomaliesDashboard(
            userRole: 'MANAGER',
            anomalies: anomalies,
          ),
        ),
      ),
    );
  }
}
