import 'package:flutter/material.dart';
import 'widgets/usage_guidelines_inspector_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GMRD Usage Guidelines Inspector',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      home: const UsageGuidelinesInspectorScreen(),
    );
  }
}
