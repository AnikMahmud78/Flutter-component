import 'package:flutter/material.dart';
import 'widgets/fail_closed_engine_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fail-Closed Logic Engine',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const FailClosedEngineScreen(),
    );
  }
}
