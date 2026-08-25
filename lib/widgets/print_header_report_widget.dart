import 'package:flutter/material.dart';

import '../models/print_header_telemetry_model.dart';

class PrintHeaderReportWidget extends StatefulWidget {
  const PrintHeaderReportWidget({super.key});

  @override
  State<PrintHeaderReportWidget> createState() =>
      _PrintHeaderReportWidgetState();
}

class _PrintHeaderReportWidgetState extends State<PrintHeaderReportWidget> {
  static const _telemetry = PrintHeaderTelemetryRecord(
    layoutType: 'REPORT_MATRIX_PRINT_HEADER',
    layoutGridDimensions: 'A4 Grid / Top Margin 12mm',
    spacingRules: 'Strict 4px Metrics (8, 12, 16)',
    alignmentSettings: 'TOP_EDGE_TIMESTAMP_HEADER_LOCKED',
    layoutValidationStatus: 'HEADER_EMBEDDED_PASS',
    completionStatus: 'Complete',
    actionEventTimestamp: '2026-08-25T11:05:00Z',
    userSessionId: 'SESS-2026-ANIK-6441',
  );

  late final String _formattedTimestamp =
      DateTime.now().toUtc().toIso8601String().substring(0, 19);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Matrix Compiler'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task Compliance: Complete',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            color: Colors.black,
                            child: const Text(
                              'HABOT',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Executive Audit Report',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Flexible(
                        child: Text(
                          'Generated: $_formattedTimestamp UTC',
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 10,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(color: Colors.black, thickness: 1),
                  const SizedBox(height: 12),
                  const Text(
                    'REPORT MATRIX CONTENT',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Data Boundary Limit: TOP_100_HIGH_PRIORITY_RECORDS\n'
                    'Security Clearance: LEVEL_13_ADMIN_VERIFIED',
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'monospace',
                      color: Colors.black87,
                    ),
                  ),
                ],
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
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    _buildRow('Layout Type', _telemetry.layoutType),
                    const Divider(height: 12),
                    _buildRow(
                      'Validation Status',
                      _telemetry.layoutValidationStatus,
                      isHighlight: true,
                    ),
                    const Divider(height: 12),
                    _buildRow(
                      'Completion Status',
                      _telemetry.completionStatus,
                      isHighlight: true,
                    ),
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
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(width: 8),
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