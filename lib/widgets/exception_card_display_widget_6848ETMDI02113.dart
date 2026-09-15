import 'package:flutter/material.dart';
import '../models/exception_card_telemetry_model.dart';

class ExceptionCardDisplayWidget6848ETMDI02113 extends StatefulWidget {
  const ExceptionCardDisplayWidget6848ETMDI02113({super.key});

  @override
  State<ExceptionCardDisplayWidget6848ETMDI02113> createState() =>
      _ExceptionCardDisplayWidget6848ETMDI02113State();
}

class _ExceptionCardDisplayWidget6848ETMDI02113State
    extends State<ExceptionCardDisplayWidget6848ETMDI02113> {
  bool _isTransparent = false;

  ExceptionCardTelemetryRecord get _telemetry => ExceptionCardTelemetryRecord(
        stepExecutionId: 'EXEC-6848ETMDI-2026',
        executionStatus: 'PASS',
        executionTimestamp: DateTime.now().toUtc().toIso8601String(),
        stepOutcome:
            'Native display cards rendered with Material tooltips and 48x48dp target buttons.',
        userId: 'ANIK-BACKEND-ENGINEER',
        completionStatus: 'Good',
        actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
        userSessionId: 'SESS-2026-ANIK-6848',
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exception Routing Display Cards'),
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
                            'Process Execution Quality Score: Good (100%)',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Color(0xFF086C44)),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'ISO 9001:2015 Quality Management Standard compliant.',
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
            GestureDetector(
              onLongPressStart: (_) => setState(() => _isTransparent = true),
              onLongPressEnd: (_) => setState(() => _isTransparent = false),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isTransparent ? 0.4 : 1.0,
                child: Card.outlined(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('MTO Exception #9941',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 14)),
                            Tooltip(
                              message:
                                  'MTO Calculation: Queue latency overflow > 1500ms',
                              child: SizedBox(
                                width: 48,
                                height: 48,
                                child: IconButton(
                                  icon: const Icon(Icons.info_outline_rounded),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                            'Hold card to activate touch transparency inspection mode.',
                            style: TextStyle(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
              ),
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
              fontWeight:
                  isHighlight ? FontWeight.bold : FontWeight.normal,
              color: isHighlight
                  ? const Color(0xFF086C44)
                  : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
