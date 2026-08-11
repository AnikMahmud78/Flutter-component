import 'package:flutter/material.dart';
import 'widgets/anomaly_dashboard_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Real-Time Anomaly Scoring',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const AnomalyDashboardView(),
    );
  }
}
