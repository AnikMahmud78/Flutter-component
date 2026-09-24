import 'package:flutter/material.dart';
import 'models/contrast_audit_model.dart';
import 'services/wcag_contrast_calculator.dart';
import 'widgets/contrast_card.dart';
import 'widgets/accessibility_banner.dart';

void main() {
  runApp(const HABOTContrastApp());
}

class HABOTContrastApp extends StatelessWidget {
  const HABOTContrastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10192GEN-01960 WCAG Contrast',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1D1B20),
          brightness: Brightness.dark,
        ),
      ),
      home: const ContrastScreen(),
    );
  }
}

class ContrastScreen extends StatefulWidget {
  const ContrastScreen({super.key});

  @override
  State<ContrastScreen> createState() => _ContrastScreenState();
}

class _ContrastScreenState extends State<ContrastScreen> {
  late ContrastAuditModel _model;

  @override
  void initState() {
    super.initState();
    _audit();
  }

  void _audit() {
    setState(() {
      _model = WcagContrastCalculator.auditInvertedState(
        taskId: '10192GEN-01960',
        foreground: Colors.white,
        background: Colors.black,
        userId: 'USER-ANIK-8821',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WCAG Contrast Evaluator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AccessibilityBanner(rate: _model.completionRate),
            const SizedBox(height: 16.0),
            ContrastCard(model: _model, onReAudit: _audit),
          ],
        ),
      ),
    );
  }
}
