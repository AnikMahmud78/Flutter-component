import 'package:flutter/material.dart';
import 'widgets/pareto_check_sheet_logger.dart';
import 'widgets/quality_execution_banner.dart';

void main() {
  runApp(const ParetoCollectorApp());
}

class ParetoCollectorApp extends StatelessWidget {
  const ParetoCollectorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pareto Check Sheet Collector',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
      ),
      home: const ParetoCollectorScreen(),
    );
  }
}

class ParetoCollectorScreen extends StatelessWidget {
  const ParetoCollectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pareto Data Collector (FIEVR-040-A09)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const QualityExecutionBanner(qualityScore: 1.0, status: 'Complete'),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: const ParetoCheckSheetLogger(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
