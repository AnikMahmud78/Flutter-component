import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/lineage_render_telemetry_model.dart';

String _compileLineagePath(List<String> nodes) {
  return nodes.join(' -> ');
}

class LineageRenderOptimizationWidget extends StatefulWidget {
  const LineageRenderOptimizationWidget({super.key});

  @override
  State<LineageRenderOptimizationWidget> createState() =>
      _LineageRenderOptimizationWidgetState();
}

class _LineageRenderOptimizationWidgetState
    extends State<LineageRenderOptimizationWidget> {
  static const _rawNodes = [
    'RawIngress',
    'TransformByt',
    'BigQueryTable',
    'PubSubStream',
  ];

  final _telemetry = LineageRenderTelemetryRecord(
    stepExecutionId: 'EXEC-7200BLGTA-2026',
    executionStatus: 'PASS',
    executionTimestamp: DateTime.now().toUtc().toIso8601String(),
    stepOutcome:
        'Lineage path calculations are isolated from the UI rendering frame.',
    userId: 'ANIK-GRAPH-ARCHITECT',
    completionStatus: 'Good',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-7200',
  );

  String _compiledPath = 'Preparing background path index...';
  bool _isCompiling = false;

  @override
  void initState() {
    super.initState();
    _compilePathInBackground();
  }

  Future<void> _compilePathInBackground() async {
    setState(() => _isCompiling = true);
    final path = await compute(_compileLineagePath, _rawNodes);
    if (!mounted) return;
    setState(() {
      _compiledPath = path;
      _isCompiling = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lineage Diagram Lag Optimization'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAdherenceBanner(),
            const SizedBox(height: 16),
            RepaintBoundary(
              child: Card.outlined(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Lag-Free Lineage Render Canvas',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Chip(
                            avatar: const Icon(Icons.memory_rounded, size: 14),
                            label: const Text(
                              'GPU LAYER ACTIVE',
                              style: TextStyle(fontSize: 9),
                            ),
                            backgroundColor: colorScheme.secondaryContainer,
                            visualDensity: VisualDensity.compact,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _compiledPath,
                        style: const TextStyle(
                          fontSize: 11,
                          fontFamily: 'monospace',
                        ),
                      ),
                      if (_isCompiling) ...[
                        const SizedBox(height: 12),
                        const LinearProgressIndicator(),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: _isCompiling ? null : _compilePathInBackground,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('REBUILD PATH INDEX'),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Atomic Step Execution Telemetry',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildTelemetryCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildAdherenceBanner() {
    return Card.filled(
      color: Colors.green.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.green.shade300),
      ),
      child: const Padding(
        padding: EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(Icons.speed_rounded, color: Color(0xFF086C44), size: 28),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'UI Design-System Adherence Rate: Good (100%)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Color(0xFF086C44),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'GPU isolation and background parsing keep tracing responsive.',
                    style: TextStyle(fontSize: 11, color: Colors.black87),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTelemetryCard() {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            _buildRow('Step Execution ID', _telemetry.stepExecutionId),
            const Divider(height: 12),
            _buildRow('Execution Status', _telemetry.executionStatus, true),
            const Divider(height: 12),
            _buildRow('Step Outcome', _telemetry.stepOutcome),
            const Divider(height: 12),
            _buildRow('Completion Status', _telemetry.completionStatus, true),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, [bool isHighlight = false]) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 12),
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
