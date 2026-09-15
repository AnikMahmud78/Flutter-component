import 'package:flutter/material.dart';
import '../models/compiler_gate_telemetry_model.dart';

class CompilerGateWidget4164FEBFL005A05 extends StatefulWidget {
  const CompilerGateWidget4164FEBFL005A05({super.key});

  @override
  State<CompilerGateWidget4164FEBFL005A05> createState() =>
      _CompilerGateWidget4164FEBFL005A05State();
}

class _CompilerGateWidget4164FEBFL005A05State
    extends State<CompilerGateWidget4164FEBFL005A05> {
  CompilerGateTelemetryRecord get _telemetry => CompilerGateTelemetryRecord(
        configurationKey: 'RESTRICT_INLINE_CUSTOM_CSS_RULE',
        configurationValue: 'ENFORCE_PRIVATE_NPM_IMPORTS_ONLY',
        configurationType: 'COMPILER_COMPLIANCE_GATE',
        validationStatus: 'VALIDATED_0.99_PASS_RATE',
        configurationTimestamp: DateTime.now().toUtc().toIso8601String(),
        completionStatus: 'Pass',
        actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
        userSessionId: 'SESS-2026-ANIK-4164',
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compiler CSS Restriction Gate'),
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
                    Icon(Icons.gavel_rounded, color: Color(0xFF086C44), size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Compliance Gate Pass Rate: Pass (0.99 Rate)',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF086C44)),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Compiler parameter restricts inline CSS; builds reject local style overrides.',
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
                    Text('Rule: ${telemetry.configurationKey}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text('Value: ${telemetry.configurationValue}',
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
                    _buildRow('Config Key', telemetry.configurationKey),
                    const Divider(height: 12),
                    _buildRow('Validation Status', telemetry.validationStatus, isHighlight: true),
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
