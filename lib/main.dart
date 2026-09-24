import 'package:flutter/material.dart';
import 'models/chart_benchmark_model.dart';
import 'widgets/chart_benchmark_card.dart';

void main() {
  runApp(const ChartBenchmarkApp());
}

class ChartBenchmarkApp extends StatelessWidget {
  const ChartBenchmarkApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HABOT Chart Benchmark',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan)),
      home: const ChartBenchmarkScreen(),
    );
  }
}

class ChartBenchmarkScreen extends StatefulWidget {
  const ChartBenchmarkScreen({Key? key}) : super(key: key);

  @override
  State<ChartBenchmarkScreen> createState() => _ChartBenchmarkScreenState();
}

class _ChartBenchmarkScreenState extends State<ChartBenchmarkScreen> {
  ChartBenchmarkModel _model = const ChartBenchmarkModel(accuracyScore: 0.995, loadTimeMs: 165);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chart Telemetry Profiler')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ChartBenchmarkCard(
              model: _model,
              onBenchmarkChart: () {
                setState(() {
                  _model = const ChartBenchmarkModel(accuracyScore: 0.998, loadTimeMs: 140);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
