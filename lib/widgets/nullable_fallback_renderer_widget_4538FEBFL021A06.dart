import 'package:flutter/material.dart';
import '../models/nullable_fallback_telemetry_model_4538FEBFL021A06.dart';

class NullableFallbackRendererWidget4538FEBFL021A06 extends StatefulWidget {
  const NullableFallbackRendererWidget4538FEBFL021A06({super.key});

  @override
  State<NullableFallbackRendererWidget4538FEBFL021A06> createState() =>
      _NullableFallbackRendererWidget4538FEBFL021A06State();
}

class _NullableFallbackRendererWidget4538FEBFL021A06State
    extends State<NullableFallbackRendererWidget4538FEBFL021A06> {
  final String? _missingDataValue = null;
  final String _validDataValue = 'Operational System Track 01';

  NullableFallbackTelemetryRecord get _telemetry => NullableFallbackTelemetryRecord(
        layoutType: 'NULLABLE_FIELD_FALLBACK_RENDERER',
        layoutGridDimensions: 'Dynamic Fallback Card Array',
        spacingRules: 'Material Empty State Formatting',
        alignmentSettings: 'CENTERED_EMPTY_TEXT_PLACEHOLDERS',
        layoutValidationStatus: 'FALLBACK_MAPPINGS_VERIFIED_PASS',
        completionStatus: 'Complete',
        actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
        userSessionId: 'SESS-2026-ANIK-4538',
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nullable Field UI Fallbacks'),
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
                    Icon(Icons.data_object_rounded, color: Color(0xFF086C44), size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Requirements Discovery Coverage: Complete (100%)',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF086C44))),
                          SizedBox(height: 2),
                          Text('Discovery reaches near-complete coverage before downstream build work starts.',
                              style: TextStyle(fontSize: 11, color: Colors.black87)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Data Render Pipeline Tests',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Valid Parameter Feed:'),
                        Text(_validDataValue, style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Missing/Null Payload Bind:'),
                        Text(_missingDataValue ?? 'Data Unavailable (Safe Fallback)',
                            style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)),
                      ],
                    ),
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
                    _buildRow('Layout Validation Status', telemetry.layoutValidationStatus, isHighlight: true),
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
          child: Text(value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
                color: isHighlight ? const Color(0xFF086C44) : Colors.blueGrey,
              )),
        ),
      ],
    );
  }
}
