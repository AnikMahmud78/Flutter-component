import 'package:flutter/material.dart';
import 'models/liveness_health_model.dart';
import 'services/liveness_evaluator_engine.dart';
import 'widgets/health_criteria_card.dart';
import 'widgets/liveness_status_banner.dart';

void main() {
  runApp(const HABOTLivenessApp());
}

class HABOTLivenessApp extends StatelessWidget {
  const HABOTLivenessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10324GEN-02095 Liveness Handshake',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00687A)),
      ),
      home: const LivenessScreen(),
    );
  }
}

class LivenessScreen extends StatefulWidget {
  const LivenessScreen({super.key});

  @override
  State<LivenessScreen> createState() => _LivenessScreenState();
}

class _LivenessScreenState extends State<LivenessScreen> {
  late LivenessHealthModel _model;

  @override
  void initState() {
    super.initState();
    _probe();
  }

  void _probe() {
    setState(() {
      _model = LivenessEvaluatorEngine.evaluateResponse(
        taskId: '10324GEN-02095',
        statusCode: 200,
        latencyMs: 42.0,
        userId: 'USER-ANIK-8821',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liveness Criteria Verifier')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LivenessStatusBanner(rate: _model.stepCompletionRate),
            const SizedBox(height: 16.0),
            HealthCriteriaCard(model: _model, onPing: _probe),
          ],
        ),
      ),
    );
  }
}
