import 'package:flutter/material.dart';
import 'widgets/sla_fault_simulator.dart';

void main() {
  runApp(const SlaFaultApp());
}

class SlaFaultApp extends StatelessWidget {
  const SlaFaultApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.red),
      home: Scaffold(
        appBar: AppBar(title: const Text('SLA Fault Injection Suite')),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: SlaFaultSimulator(),
        ),
      ),
    );
  }
}
