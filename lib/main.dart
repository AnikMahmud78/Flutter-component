import 'package:flutter/material.dart';
import 'models/plain_language_model.dart';
import 'services/readability_calculator.dart';
import 'widgets/plain_text_card.dart';
import 'widgets/language_score_banner.dart';

void main() {
  runApp(const HABOTPlainLanguageApp());
}

class HABOTPlainLanguageApp extends StatelessWidget {
  const HABOTPlainLanguageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10280GEN-02051 Plain Language',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF006689)),
      ),
      home: const PlainLanguageScreen(),
    );
  }
}

class PlainLanguageScreen extends StatefulWidget {
  const PlainLanguageScreen({super.key});

  @override
  State<PlainLanguageScreen> createState() => _PlainLanguageScreenState();
}

class _PlainLanguageScreenState extends State<PlainLanguageScreen> {
  late PlainLanguageModel _model;

  @override
  void initState() {
    super.initState();
    _analyze();
  }

  void _analyze() {
    setState(() {
      _model = ReadabilityCalculator.analyzeText(
        taskId: '10280GEN-02051',
        text: 'Select your preferred data sync window to upload offline logs.',
        userId: 'USER-ANIK-8821',
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MD3 Plain Language Evaluator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LanguageScoreBanner(rate: _model.completionRate),
            const SizedBox(height: 16.0),
            PlainTextCard(model: _model, onReCheck: _analyze),
          ],
        ),
      ),
    );
  }
}
