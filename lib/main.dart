import 'package:flutter/material.dart';
import 'models/blocked_state_model.dart';
import 'services/blocked_state_evaluator.dart';
import 'widgets/action_blocked_card.dart';
import 'widgets/step_rate_banner.dart';

void main() {
  runApp(const HABOTBlockedApp());
}

class HABOTBlockedApp extends StatelessWidget {
  const HABOTBlockedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10225GEN-01994 Action Blocked State',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB3261E)),
      ),
      home: const BlockedScreen(),
    );
  }
}

class BlockedScreen extends StatefulWidget {
  const BlockedScreen({super.key});

  @override
  State<BlockedScreen> createState() => _BlockedScreenState();
}

class _BlockedScreenState extends State<BlockedScreen> {
  late BlockedStateModel _model;

  @override
  void initState() {
    super.initState();
    _model = BlockedStateEvaluator.generateState(
      taskId: '10225GEN-01994',
      userId: 'USER-ANIK-8821',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Action Blocked UI State')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            StepRateBanner(rate: _model.completionRate),
            const SizedBox(height: 16.0),
            ActionBlockedCard(model: _model),
          ],
        ),
      ),
    );
  }
}
