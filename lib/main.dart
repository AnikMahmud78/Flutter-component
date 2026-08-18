import 'package:flutter/material.dart';
import 'widgets/hesitation_tracker_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hesitation Telemetry Instrumentation Engine',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const HesitationTrackerWidget(),
    );
  }
}
