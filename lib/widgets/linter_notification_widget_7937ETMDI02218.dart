import 'package:flutter/material.dart';
import '../models/linter_notification_telemetry_model.dart';

class LinterNotificationWidget7937ETMDI02218 extends StatefulWidget {
  const LinterNotificationWidget7937ETMDI02218({super.key});

  @override
  State<LinterNotificationWidget7937ETMDI02218> createState() =>
      _LinterNotificationWidget7937ETMDI02218State();
}

class _LinterNotificationWidget7937ETMDI02218State
    extends State<LinterNotificationWidget7937ETMDI02218> {
  bool _isExpanded = false;

  LinterNotificationTelemetryRecord get _telemetry =>
      LinterNotificationTelemetryRecord(
        stepExecutionId: 'EXEC-7937ETMDI-2026',
        executionStatus: 'PASS',
        executionTimestamp: DateTime.now().toUtc().toIso8601String(),
        stepOutcome:
            'Linter rule deployed purging human terms; objective notification pattern active.',
        userId: 'ANIK-OPS-ANALYST',
        completionStatus: 'Good',
        actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
        userSessionId: 'SESS-2026-ANIK-7937',
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Objective Notification Patterns'),
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
                    Icon(Icons.verified_rounded, color: Color(0xFF086C44), size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Observability / Alert Coverage: Good (100%)',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Color(0xFF086C44)),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Compliant with Google SRE Handbook — Monitoring Distributed Systems.',
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
            ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) {
                setState(() => _isExpanded = !isExpanded);
              },
              children: [
                ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return const ListTile(
                      title: Text('Objective System Notification #104',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Status: Linter Purge Rule Enforced'),
                    );
                  },
                  body: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Automated rule scan complete: All human action terminology purged from active code trees.',
                      style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
                    ),
                  ),
                  isExpanded: _isExpanded,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text('Atomic Telemetry Logs',
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildRow('Step Execution ID', telemetry.stepExecutionId),
                    const Divider(height: 12),
                    _buildRow('Execution Status', telemetry.executionStatus,
                        isHighlight: true),
                    const Divider(height: 12),
                    _buildRow('Completion Status', telemetry.completionStatus,
                        isHighlight: true),
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
        Text(label,
            style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.grey)),
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
