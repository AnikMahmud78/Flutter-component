import 'package:flutter/material.dart';
import '../models/adoption_metrics_telemetry_model.dart';

class AdoptionMetricsLoggerWidget7871FEBFL005A18 extends StatefulWidget {
  const AdoptionMetricsLoggerWidget7871FEBFL005A18({super.key});

  @override
  State<AdoptionMetricsLoggerWidget7871FEBFL005A18> createState() =>
      _AdoptionMetricsLoggerWidget7871FEBFL005A18State();
}

class _AdoptionMetricsLoggerWidget7871FEBFL005A18State
    extends State<AdoptionMetricsLoggerWidget7871FEBFL005A18> {
  AdoptionMetricsTelemetryRecord get _telemetry => AdoptionMetricsTelemetryRecord(
        configurationParameter: 'COMPONENT_ADOPTION_METRICS_STREAM',
        currentSetting: 'STREAMING_TO_BACKGROUND_INTERFACE_LOGS',
        previousSetting: 'LOCAL_LOGGING_IDLE',
        changeLog: 'Streaming pipeline configured for private NPM package component adoption.',
        configurationTimestamp: DateTime.now().toUtc().toIso8601String(),
        completionStatus: 'Complete',
        actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
        userSessionId: 'SESS-2026-ANIK-7871',
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Component Adoption Metrics Stream'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card.filled(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.green.shade300),
              ),
              child: const Padding(
                padding: EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(Icons.analytics_rounded, color: Color(0xFF086C44), size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Typography Token Adherence: Complete (100%)',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF086C44)),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Component adoption metrics streaming actively to background interface logs.',
                            style: TextStyle(fontSize: 11, color: Colors.black87),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card.outlined(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Parameter: ${telemetry.configurationParameter}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text('Current Setting: ${telemetry.currentSetting}',
                        style: const TextStyle(fontSize: 11, fontFamily: 'monospace')),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Atomic Telemetry Logs',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildRow('Config Parameter', telemetry.configurationParameter),
                    const Divider(height: 12),
                    _buildRow('Completion Status', telemetry.completionStatus, isHighlight: true),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
              color: isHighlight ? const Color(0xFF086C44) : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
