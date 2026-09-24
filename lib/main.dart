import 'package:flutter/material.dart';
import 'models/circuit_breaker_model.dart';
import 'widgets/circuit_status_card.dart';

void main() {
  runApp(const CircuitBreakerApp());
}

class CircuitBreakerApp extends StatelessWidget {
  const CircuitBreakerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Circuit Breaker Automation',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
      ),
      home: const CircuitDashboardScreen(),
    );
  }
}

class CircuitDashboardScreen extends StatefulWidget {
  const CircuitDashboardScreen({Key? key}) : super(key: key);

  @override
  State<CircuitDashboardScreen> createState() => _CircuitDashboardScreenState();
}

class _CircuitDashboardScreenState extends State<CircuitDashboardScreen> {
  late CircuitBreakerModel _model;

  @override
  void initState() {
    super.initState();
    _resetCircuit();
  }

  void _resetCircuit() {
    setState(() {
      _model = CircuitBreakerModel(
        errorRatePercentage: 0.45,
        thresholdPercentage: 2.0,
        windowMinutes: 5,
        circuitState: 'CLOSED',
        completionStatus: 'Complete',
      );
    });
  }

  void _triggerErrorSpike() {
    setState(() {
      _model = CircuitBreakerModel(
        errorRatePercentage: 3.82,
        thresholdPercentage: 2.0,
        windowMinutes: 5,
        circuitState: 'OPEN',
        completionStatus: 'Complete',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Automated Alert & Reliability Rules')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: CircuitStatusCard(
              model: _model,
              onSimulateErrorSpike: _triggerErrorSpike,
              onReset: _resetCircuit,
            ),
          ),
        ),
      ),
    );
  }
}
