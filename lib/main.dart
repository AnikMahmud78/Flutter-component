// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/lineage_graph_visualizer.dart';
import 'widgets/graph_accuracy_banner.dart';

void main() {
  runApp(const GraphVisualizerApp());
}

class GraphVisualizerApp extends StatelessWidget {
  const GraphVisualizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lineage Graph Visualizer',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const VisualizerScreen(),
    );
  }
}

class VisualizerScreen extends StatelessWidget {
  const VisualizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lineage Graph Visualizer (GEN-00878)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            GraphAccuracyBanner(status: 'Pass'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: LineageGraphVisualizer(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
