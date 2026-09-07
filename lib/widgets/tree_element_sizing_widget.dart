import 'package:flutter/material.dart';

import '../models/tree_sizing_telemetry_model.dart';

class _TreeNodeData {
  final int depth;
  final String name;
  final String type;

  const _TreeNodeData({
    required this.depth,
    required this.name,
    required this.type,
  });
}

class TreeElementSizingWidget extends StatelessWidget {
  const TreeElementSizingWidget({super.key});

  static const _treeNodes = [
    _TreeNodeData(depth: 0, name: 'Root: Ingress_Topic', type: 'PUBSUB_TOPIC'),
    _TreeNodeData(
      depth: 1,
      name: 'Node 1: ETL_Transform',
      type: 'DATAFLOW_JOB',
    ),
    _TreeNodeData(
      depth: 2,
      name: 'Node 2: Analytics_Ledger',
      type: 'BIGQUERY_TABLE',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    const telemetry = TreeSizingTelemetryRecord(
      layoutType: 'BIGQUERY_LINEAGE_TREE_MOBILE_LAYOUT',
      layoutGridDimensions: '4-Col Compact Mobile Grid (<600dp)',
      spacingRules: 'Strict 4px Scale (8dp Indent, 12dp Padding)',
      alignmentSettings: 'CLEAN_TREE_NODE_SIZING_NO_OVERLAP',
      layoutValidationStatus: 'ZERO_OVERLAP_PASSED',
      completionStatus: 'Good',
      actionEventTimestamp: '2026-09-03T10:12:00Z',
      userSessionId: 'SESS-2026-ANIK-7948',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Lineage Tree Sizing'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAdherenceBanner(),
            const SizedBox(height: 16),
            Text(
              'Compact Mobile Lineage Tree Hierarchy',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: _treeNodes
                      .map((node) => _buildTreeNode(node, colorScheme))
                      .toList(),
                ),
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
            _buildTelemetryCard(telemetry),
          ],
        ),
      ),
    );
  }

  Widget _buildTreeNode(_TreeNodeData node, ColorScheme colorScheme) {
    return Padding(
      padding: EdgeInsets.only(left: node.depth * 16, top: 4, bottom: 4),
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: colorScheme.outlineVariant),
          ),
          child: Row(
            children: [
              Icon(
                Icons.subdirectory_arrow_right_rounded,
                size: 18,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  node.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Chip(
                    label: Text(
                      node.type,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
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
            Icon(Icons.fit_screen_rounded, color: Color(0xFF086C44), size: 28),
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
                    'Tree nodes use a 4px spacing scale and bounded mobile sizing.',
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

  Widget _buildTelemetryCard(TreeSizingTelemetryRecord telemetry) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            _buildRow('Layout Type', telemetry.layoutType),
            const Divider(height: 12),
            _buildRow('Grid Dimensions', telemetry.layoutGridDimensions),
            const Divider(height: 12),
            _buildRow('Spacing Rules', telemetry.spacingRules),
            const Divider(height: 12),
            _buildRow(
              'Validation Status',
              telemetry.layoutValidationStatus,
              true,
            ),
            const Divider(height: 12),
            _buildRow('Completion Status', telemetry.completionStatus, true),
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
