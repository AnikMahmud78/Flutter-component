import 'package:flutter/material.dart';
import 'models/local_execution_model.dart';
import 'services/local_state_evaluator.dart';
import 'widgets/local_logic_card.dart';
import 'widgets/client_state_banner.dart';

void main() {
  runApp(const HABOTLocalApp());
}

class HABOTLocalApp extends StatelessWidget {
  const HABOTLocalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10346GEN-02118 Local JS/Dart Logic',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00639A)),
      ),
      home: const LocalScreen(),
    );
  }
}

class LocalScreen extends StatefulWidget {
  const LocalScreen({super.key});

  @override
  State<LocalScreen> createState() => _LocalScreenState();
}

class _LocalScreenState extends State<LocalScreen> {
  late LocalExecutionModel _model;

  @override
  void initState() {
    super.initState();
    _run();
  }

  void _run() {
    setState(() {
      _model = LocalStateEvaluator.runLocalLogic(
        taskId: '10346GEN-02118',
        userId: 'USER-ANIK-8821',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Local In-Memory Logic Engine')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClientStateBanner(rate: _model.completionRate),
            const SizedBox(height: 16.0),
            LocalLogicCard(model: _model, onExecute: _run),
          ],
        ),
      ),
    );
  }
}
