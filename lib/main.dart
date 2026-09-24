import 'package:flutter/material.dart';
import 'models/launch_benchmark_model.dart';
import 'widgets/dashboard_launch_card.dart';

void main() {
  runApp(const LaunchBenchmarkApp());
}

class LaunchBenchmarkApp extends StatelessWidget {
  const LaunchBenchmarkApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HABOT Launch Benchmark',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey)),
      home: const LaunchBenchmarkScreen(),
    );
  }
}

class LaunchBenchmarkScreen extends StatefulWidget {
  const LaunchBenchmarkScreen({Key? key}) : super(key: key);

  @override
  State<LaunchBenchmarkScreen> createState() => _LaunchBenchmarkScreenState();
}

class _LaunchBenchmarkScreenState extends State<LaunchBenchmarkScreen> {
  LaunchBenchmarkModel _benchmark = LaunchBenchmarkModel(
    renderTimeMs: 84,
    benchmarkTime: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Performance Profiler')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DashboardLaunchCard(
              model: _benchmark,
              onRunBenchmark: () {
                setState(() {
                  _benchmark = LaunchBenchmarkModel(
                    renderTimeMs: 76,
                    benchmarkTime: DateTime.now(),
                  );
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
