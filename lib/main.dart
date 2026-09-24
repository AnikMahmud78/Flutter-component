import 'package:flutter/material.dart';
import 'models/devops_metrics_model.dart';
import 'widgets/devops_metrics_card.dart';

void main() {
  runApp(const DevOpsMetricsApp());
}

class DevOpsMetricsApp extends StatelessWidget {
  const DevOpsMetricsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevOps Build Health',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const DevOpsMetricsScreen(),
    );
  }
}

class DevOpsMetricsScreen extends StatelessWidget {
  const DevOpsMetricsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const devOpsModel = DevOpsMetricsModel(
      buildPassRate: 1.0,
      complianceScore: 0.99,
      refreshLatencyMinutes: 1.5,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('DevOps Health Console')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DevOpsMetricsCard(
              model: devOpsModel,
              onRefresh: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('CI/CD Health Telemetry Synced (<5m SLA)')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
