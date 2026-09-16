import 'package:flutter/material.dart';
import 'widgets/graph_traceability_card.dart';
import 'widgets/rcae_quality_banner.dart';

void main() {
  runApp(const TraceabilityApp());
}

class TraceabilityApp extends StatelessWidget {
  const TraceabilityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graph Traceability Dashboard',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const TraceabilityScreen(),
    );
  }
}

class TraceabilityScreen extends StatelessWidget {
  const TraceabilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RCAE Traceability (FIEVR-046-15)')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const RcaeQualityBanner(qualityScore: 1.0, status: 'Good (100%)'),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: GraphTraceabilityCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
