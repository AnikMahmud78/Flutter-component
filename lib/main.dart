// lib/main.dart
import 'package:flutter/material.dart';
import 'models/attribution_model.dart';
import 'widgets/fk_mapping_card.dart';
import 'widgets/integrity_status_banner.dart';

void main() {
  runApp(const AttributionApp());
}

class AttributionApp extends StatelessWidget {
  const AttributionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attribution Anchor Definition',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const AttributionScreen(),
    );
  }
}

class AttributionScreen extends StatelessWidget {
  const AttributionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const model = AttributionModel(
      id: 'ED-ATTRIB-9901',
      predecessorId: 'ED-ATTRIB-9900',
      sourceDocumentId: 'SD-CLICK-4402',
      campaignToken: 'CMP-META-2026',
      completionStatus: 'Complete',
      actionEventTimestamp: '2026-09-16T12:47:00.000Z',
      userSessionId: 'SESS-GEN-0381',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Attribution Anchor (GEN-00381)')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const IntegrityStatusBanner(status: 'Complete'),
            FkMappingCard(model: model),
          ],
        ),
      ),
    );
  }
}
