import 'package:flutter/material.dart';
import 'widgets/ha_dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HA Database Multi-Zone Policies',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const HaDashboardScreen(),
    );
  }
}
