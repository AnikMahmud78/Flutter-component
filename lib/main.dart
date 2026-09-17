// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/cta_regex_bind_card.dart';
import 'widgets/structural_integrity_banner.dart';

void main() {
  runApp(const CtaRegexBindScreenApp());
}

class CtaRegexBindScreenApp extends StatelessWidget {
  const CtaRegexBindScreenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CTA Regex Interlock (GEN-01089)',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const CtaRegexBindScreen(),
    );
  }
}

class CtaRegexBindScreen extends StatelessWidget {
  const CtaRegexBindScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CTA Regex Interlock (GEN-01089)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            StructuralIntegrityBanner(status: 'Pass', integrity: 1.0),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CtaRegexBindCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
