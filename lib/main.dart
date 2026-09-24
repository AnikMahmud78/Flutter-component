import 'package:flutter/material.dart';
import 'widgets/canary_rollback_tester.dart';

void main() {
  runApp(const CanaryApp());
}

class CanaryApp extends StatelessWidget {
  const CanaryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepOrange),
      home: Scaffold(
        appBar: AppBar(title: const Text('Canary Deployment Circuit Breaker')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: CanaryRollbackTester(),
        ),
      ),
    );
  }
}
