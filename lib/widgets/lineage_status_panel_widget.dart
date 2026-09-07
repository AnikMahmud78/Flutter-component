import 'package:flutter/material.dart';

import '../models/lineage_status_panel_telemetry_model.dart';

class LineageStatusPanelWidget extends StatelessWidget {
  const LineageStatusPanelWidget({super.key});

  static const _paths = [
    (
      path: 'RawIngress -> BigQueryTable',
      depth: '4 hops',
      status: 'PRE_COMPILED',
    ),
    (
      path: 'PubSubStream -> AnalyticsLedger',
      depth: '3 hops',
      status: 'PRE_COMPILED',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    const telemetry = LineageStatusPanelTelemetryRecord(
      mobilePlatform: 'Flutter Mobile / Android & iOS',
      osVersion: 'Android 15 / iOS 18',
      deviceType: 'Compact Mobile Handheld (<600dp)',
      screenDimensions: '360 x 740 dp',
      mobileConfiguration: 'BIGQUERY_LINEAGE_PANEL_ACTIVE',
      completionStatus: 'Good',
      actionEventTimestamp: '2026-09-03T10:12:00Z',
      userSessionId: 'SESS-2026-ANIK-6870',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('BigQuery Lineage Graph Panels'),
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
              'Pre-Compiled Path Indexing',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ..._paths.map(
              (path) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: _buildPathCard(path, colorScheme),
              ),
            ),
            const SizedBox(height: 16),
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
            Icon(
              Icons.account_tree_rounded,
              color: Color(0xFF086C44),
              size: 28,
            ),
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
                    'Material Design 3 status panels are ready for lineage tracing.',
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

  Widget _buildPathCard(
    ({String path, String depth, String status}) path,
    ColorScheme colorScheme,
  ) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.route_rounded, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    path.path,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                Chip(
                  label: Text(path.status, style: const TextStyle(fontSize: 9)),
                  backgroundColor: colorScheme.secondaryContainer,
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              '${path.depth} - instant indexed lookup active',
              style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTelemetryCard(LineageStatusPanelTelemetryRecord telemetry) {
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            _buildRow('Mobile Platform', telemetry.mobilePlatform),
            const Divider(height: 12),
            _buildRow('Device Type', telemetry.deviceType),
            const Divider(height: 12),
            _buildRow('Mobile Config', telemetry.mobileConfiguration),
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
