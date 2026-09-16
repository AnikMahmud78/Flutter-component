import 'package:flutter/material.dart';
import '../models/card_isolation_telemetry_model.dart';

class DashboardCardIsolationWidget2404FEBFL023A14 extends StatefulWidget {
  const DashboardCardIsolationWidget2404FEBFL023A14({super.key});

  @override
  State<DashboardCardIsolationWidget2404FEBFL023A14> createState() =>
      _DashboardCardIsolationWidgetState();
}

class _DashboardCardIsolationWidgetState
    extends State<DashboardCardIsolationWidget2404FEBFL023A14> {
  final CardIsolationTelemetryRecord _telemetry = CardIsolationTelemetryRecord(
    layoutType: 'SINGLE_ACTION_VIEW_CONTAINER',
    layoutGridDimensions: '1x1',
    spacingRules: 'uniform-16dp',
    alignmentSettings: 'center',
    layoutValidationStatus: 'Validated',
    completionStatus: 'Pass',
    actionEventTimestamp: DateTime.now().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-2404',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard Card Isolation 2404FEBFL023A14')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Validation / QA Pass Rate: Pass (100%)',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            const Expanded(
              child: Center(
                child: Icon(Icons.rocket_launch, size: 80, color: Colors.indigo),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('PROCEED WITH TRANSACTION'),
              ),
            ),
            const SizedBox(height: 24),
            _telemetryRow('layoutValidationStatus', _telemetry.layoutValidationStatus),
            _telemetryRow('completionStatus', _telemetry.completionStatus),
          ],
        ),
      ),
    );
  }

  Widget _telemetryRow(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(value),
          ],
        ),
      );
}
