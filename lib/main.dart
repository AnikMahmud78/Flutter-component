// lib/main.dart
import 'package:flutter/material.dart';
import 'widgets/pii_normalizer_card.dart';
import 'widgets/capi_normalization_banner.dart';

void main() {
  runApp(const PiiNormalizerApp());
}

class PiiNormalizerApp extends StatelessWidget {
  const PiiNormalizerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PII Normalization Pipeline',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const NormalizerScreen(),
    );
  }
}

class NormalizerScreen extends StatelessWidget {
  const NormalizerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PII Normalization (GEN-00811)')),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            CapiNormalizationBanner(status: 'Complete'),
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: PiiNormalizerCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
