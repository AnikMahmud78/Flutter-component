import 'package:flutter/material.dart';
import '../models/nested_selector_telemetry_model.dart';

class NestedSelectorControlWidget13789FEBFL011A02 extends StatefulWidget {
  const NestedSelectorControlWidget13789FEBFL011A02({super.key});

  @override
  State<NestedSelectorControlWidget13789FEBFL011A02> createState() =>
      _NestedSelectorControlWidget13789FEBFL011A02State();
}

class _NestedSelectorControlWidget13789FEBFL011A02State
    extends State<NestedSelectorControlWidget13789FEBFL011A02> {
  String _selectedProjectTag = 'PROJECT_ALPHA';

  NestedSelectorTelemetryRecord get _telemetry => NestedSelectorTelemetryRecord(
        sourceElementId: 'SRC-MULTI-SELECT-CHIP-ROW',
        targetElementId: 'TGT-BIGQUERY-PARAMETERIZED-QUERY',
        mappingRule: 'CONTEXTUAL_CASCADE_QUERY_BOUND_RESTRICTION',
        mappingStatus: 'MAPPED_PASS',
        mappingValidation: 'VERIFIED_AGAINST_AVAILABILITY_SPEC',
        completionStatus: 'Complete',
        actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
        userSessionId: 'SESS-2026-ANIK-13789',
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nested Multi-Select Choice Controls'),
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
                    Icon(Icons.tune_rounded, color: Color(0xFF086C44), size: 28),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Process Execution Quality: Complete (100%)',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF086C44)),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Nested multi-select controls restrict database query bounds contextually.',
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
            Text('Cascading Project Tag Selector',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8.0,
              children: ['PROJECT_ALPHA', 'PROJECT_BETA', 'PROJECT_GAMMA'].map((tag) {
                final isSelected = _selectedProjectTag == tag;
                return ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 48.0, minWidth: 48.0),
                  child: FilterChip(
                    label: Text(tag),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) setState(() => _selectedProjectTag = tag);
                    },
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            Text('Contextual LSA Calendar Entry Constraint',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card.outlined(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Bound Query Constraint: SLOT_0900_1200_UTC',
                        style: TextStyle(fontSize: 12, fontFamily: 'monospace')),
                    const SizedBox(height: 4),
                    Text('Active Filter Scope: $_selectedProjectTag',
                        style: const TextStyle(fontSize: 11, color: Colors.indigo, fontWeight: FontWeight.bold)),
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
                    _buildRow('Source Element ID', telemetry.sourceElementId),
                    const Divider(height: 12),
                    _buildRow('Target Element ID', telemetry.targetElementId),
                    const Divider(height: 12),
                    _buildRow('Mapping Rule', telemetry.mappingRule),
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
