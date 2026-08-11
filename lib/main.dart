import 'package:flutter/material.dart';
import 'widgets/circuit_breaker_demo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Circuit Breaker Pattern',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Istio Circuit Breaker Guard'),
          backgroundColor: Colors.blue.shade50,
        ),
        body: const CircuitBreakerDemo(),
      ),
    );
  }
}
