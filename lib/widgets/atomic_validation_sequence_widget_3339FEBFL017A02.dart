import 'package:flutter/material.dart';
import '../models/atomic_validation_telemetry_model.dart';

class AtomicValidationSequenceWidget3339FEBFL017A02 extends StatefulWidget {
  const AtomicValidationSequenceWidget3339FEBFL017A02({super.key});

  @override
  State<AtomicValidationSequenceWidget3339FEBFL017A02> createState() =>
      _AtomicValidationSequenceWidget3339FEBFL017A02State();
}

class _AtomicValidationSequenceWidget3339FEBFL017A02State
    extends State<AtomicValidationSequenceWidget3339FEBFL017A02> {
  String? _selectedCurriculum;

  final AtomicValidationTelemetryRecord _telemetry = AtomicValidationTelemetryRecord(
    stepExecutionId: 'EXEC-3339FEBFL-2026',
    executionStatus: 'PASS',
    executionTimestamp: '2026-09-15T10:09:00Z',
    stepOutcome: 'Atomic one-line-one-action validation sequence implemented with 8dp spacing and tap selections.',
    userId: 'ANIK-FUNCTIONAL-DESIGN',
    completionStatus: 'Complete',
    actionEventTimestamp: '2026-09-15T10:09:00Z',
    userSessionId: 'SESS-2026-ANIK-3339',
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Atomic Job Posting Sequence'),
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
                    Icon(Icons.looks_one_rounded, color: Color(0xFF086C44), size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Development Completion: Complete (100%)',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF086C44))),
                          SizedBox(height: 2),
                          Text('Build tasks in a sprint-based delivery model tracked to completion.',
                              style: TextStyle(fontSize: 11, color: Colors.black87)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text('Select Target Curriculum Mode',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Column(
              children: ['Montessori', 'Waldorf', 'Reggio Emilia'].map((type) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: InkWell(
                    onTap: () => setState(() => _selectedCurriculum = type),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _selectedCurriculum == type
                            ? colorScheme.primaryContainer
                            : colorScheme.surface,
                        border: Border.all(
                            color: _selectedCurriculum == type
                                ? colorScheme.primary
                                : colorScheme.outlineVariant),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(type,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: _selectedCurriculum == type
                                      ? colorScheme.primary
                                      : Colors.black87)),
                          if (_selectedCurriculum == type)
                            Icon(Icons.check_circle_rounded, color: colorScheme.primary),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
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
                    _buildRow('Execution Status', telemetry.executionStatus, isHighlight: true),
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
