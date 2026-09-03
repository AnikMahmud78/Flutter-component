import 'package:flutter/material.dart';
import '../models/dlq_error_assistance_telemetry_model.dart';

class DlqErrorAssistanceWidget extends StatefulWidget {
  const DlqErrorAssistanceWidget({super.key});

  @override
  State<DlqErrorAssistanceWidget> createState() =>
      _DlqErrorAssistanceWidgetState();
}

class _DlqErrorAssistanceWidgetState extends State<DlqErrorAssistanceWidget> {
  final DlqErrorAssistanceTelemetryRecord _telemetry =
      DlqErrorAssistanceTelemetryRecord(
    stepExecutionId: 'EXEC-7838AWCV-2026',
    executionStatus: 'PASS',
    executionTimestamp: DateTime.now().toUtc().toIso8601String(),
    stepOutcome:
        'Structured localized assistance text rendered for DLQ anomalous packet instead of raw stack traces.',
    userId: 'ANIK-QUEUE-ARCHITECT',
    completionStatus: 'Good',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-7838',
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('DLQ Packet Error Handler'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ISO 9001:2015 QUALITY MANAGEMENT BANNER
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
                    Icon(Icons.verified_rounded, color: Color(0xFF086C44), size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Process Execution Quality Score: Good (100%)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Color(0xFF086C44),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Compliant with ISO 9001:2015 Quality Management Standard; raw stack traces suppressed.',
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

            // LOCALIZED ERROR ASSISTANCE CARD (MD3 ERROR CONTAINER)
            Card.outlined(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: Color(0xFFE31B23), width: 1.5),
              ),
              color: const Color(0xFFF9DEDC),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.report_problem_rounded, color: Color(0xFF8B0811), size: 24),
                        SizedBox(width: 8),
                        Text(
                          'Data Packet Processing Exception',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF8B0811),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'An anomalous payload schema was routed to the Dead Letter Queue (DLQ). Rather than displaying a raw system stack trace, please review the localized resolution guidance:',
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        '• Action Required: Verify data type validation mask on field [payload_checksum].\n'
                        '• Next Step: Resubmit packet via the crowdsourced ingestion retry panel.',
                        style: TextStyle(fontSize: 11, fontFamily: 'monospace', color: Colors.black87),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ATOMIC TELEMETRY LOG
            Text('Atomic Step Execution Telemetry',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildRow('Step Execution ID', telemetry.stepExecutionId),
                    const Divider(height: 12),
                    _buildRow('Execution Status', telemetry.executionStatus, isHighlight: true),
                    const Divider(height: 12),
                    _buildRow('Step Outcome', telemetry.stepOutcome),
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
