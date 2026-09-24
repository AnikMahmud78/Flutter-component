import 'package:flutter/material.dart';
import 'models/clv_economics_model.dart';
import 'services/economics_evaluator.dart';
import 'widgets/clv_ratio_card.dart';
import 'widgets/economics_status_banner.dart';

void main() {
  runApp(const HABOTClvApp());
}

class HABOTClvApp extends StatelessWidget {
  const HABOTClvApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10258GEN-02028 CLV Monitor',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2E6B27)),
      ),
      home: const ClvScreen(),
    );
  }
}

class ClvScreen extends StatefulWidget {
  const ClvScreen({super.key});

  @override
  State<ClvScreen> createState() => _ClvScreenState();
}

class _ClvScreenState extends State<ClvScreen> {
  late ClvEconomicsModel _model;

  @override
  void initState() {
    super.initState();
    _recalculate();
  }

  void _recalculate() {
    setState(() {
      _model = EconomicsEvaluator.calculateRatio(
        taskId: '10258GEN-02028',
        clv: 12500.0,
        cac: 2800.0,
        userId: 'USER-ANIK-8821',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CLV vs CAC Financial Guard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            EconomicsStatusBanner(growthRate: _model.growthRatePercent),
            const SizedBox(height: 16.0),
            ClvRatioCard(model: _model, onRefresh: _recalculate),
          ],
        ),
      ),
    );
  }
}
