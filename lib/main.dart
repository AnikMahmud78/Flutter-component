import 'package:flutter/material.dart';
import 'widgets/trace_collector_visualization_6507BPWSO02712.dart';

void main() {
  runApp(const TraceCollectorVisualization6507BPWSO02712App());
}

class TraceCollectorVisualization6507BPWSO02712App extends StatelessWidget {
  const TraceCollectorVisualization6507BPWSO02712App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Trace Collector Visualization App',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: const TraceCollectorVisualization6507BPWSO02712(),
  );
}
