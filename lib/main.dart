import 'package:flutter/material.dart';
import 'models/mathematical_validation_model.dart';
import 'services/math_check_engine.dart';
import 'widgets/math_validation_card.dart';
import 'widgets/execution_status_banner.dart';

void main() {
  runApp(const HABOTMathCheckApp());
}

class HABOTMathCheckApp extends StatelessWidget {
  const HABOTMathCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10148GEN-01916 Math Validation',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0061A4)),
      ),
      home: const MathCheckScreen(),
    );
  }
}

class MathCheckScreen extends StatefulWidget {
  const MathCheckScreen({super.key});

  @override
  State<MathCheckScreen> createState() => _MathCheckScreenState();
}

class _MathCheckScreenState extends State<MathCheckScreen> {
  late MathematicalValidationModel _currentValidation;

  @override
  void initState() {
    super.initState();
    _recalculate();
  }

  void _recalculate() {
    setState(() {
      _currentValidation = MathCheckEngine.executeCheck(
        taskId: '10148GEN-01916',
        traceId: 'TRACE-01916-2026',
        valueA: 1500.25,
        valueB: 1500.25,
        userId: 'USER-ANIK-8821',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isPassing = _currentValidation.validationAccuracy >= 99.5;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Check (A - B = 0) Engine'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _recalculate();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExecutionStatusBanner(
                statusText: isPassing
                    ? 'PASSED: Mathematical Balance Accuracy is ${_currentValidation.validationAccuracy}% (Floor: 99.5%)'
                    : 'FAILED: Threshold violation detected',
                isPass: isPassing,
              ),
              const SizedBox(height: 16.0),
              MathValidationCard(
                model: _currentValidation,
                onRefresh: _recalculate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
