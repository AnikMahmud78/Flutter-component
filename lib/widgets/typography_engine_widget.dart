import 'package:flutter/material.dart';

import '../models/font_optimization_telemetry_model.dart';

class TypographyEngine extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const TypographyEngine(
    this.text, {
    super.key,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: 1.5,
      fontFamily: 'MaterialVariableRoboto',
    ),
  );
}

class TypographyEngineInspectorWidget extends StatelessWidget {
  const TypographyEngineInspectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const telemetry = FontOptimizationTelemetryRecord(
      configurationKey: 'MOBILE_VARIABLE_FONT_SWAP_PIPELINE',
      configurationValue: 'FONT_DISPLAY_SWAP_SUBSET_UNDER_30KB',
      configurationType: 'VARIABLE_FONT_DECLARATION',
      validationStatus: 'VALIDATED_SUB_300MS_PASS',
      configurationTimestamp: '2026-09-04T08:30:00Z',
      completionStatus: 'Good',
      actionEventTimestamp: '2026-09-04T08:30:00Z',
      userSessionId: 'SESS-2026-ANIK-5055',
    );
    return Scaffold(
      appBar: AppBar(title: const Text('Lightweight Font Optimization')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card.filled(
              color: Colors.green.shade50,
              child: const ListTile(
                leading: Icon(
                  Icons.text_fields_rounded,
                  color: Color(0xFF086C44),
                ),
                title: Text('Font Load Time: Good (120ms)'),
                subtitle: Text(
                  'Variable font swap is configured with a subset payload under 30KB.',
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'TypographyEngine Render',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Card.outlined(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TypographyEngine(
                      'Primary Header Title 16sp',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(height: 8),
                    TypographyEngine(
                      'Body copy rendering with 1.5x relative line-height on mobile displays.',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Card.outlined(
              child: ListTile(
                title: Text(telemetry.configurationValue),
                subtitle: Text(
                  '${telemetry.fontLoadTimeMs}ms • ${telemetry.completionStatus}',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
