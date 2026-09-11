import 'package:flutter/material.dart';
import 'widgets/latency_contrast_dashboard_2635BTPM031A05.dart';

void main() {
  runApp(const LatencyContrastDashboard2635BTPM031A05App());
}

class LatencyContrastDashboard2635BTPM031A05App extends StatelessWidget {
  const LatencyContrastDashboard2635BTPM031A05App({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Latency Contrast App',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: const LatencyContrastDashboard2635BTPM031A05(),
  );
}
