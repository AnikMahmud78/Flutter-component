// DSDD-010-15 — BigQuery Lineage & Dataplex Streaming Test Data Grid.
// Provides a high-density Material 3 data table with touch-optimized field tooltips,
// progressive disclosure of streaming event metadata, and DAMA-DMBOK2 lineage validation.

import 'package:flutter/material.dart';

/// Model capturing atomic test log streaming event and lineage metrics.
class LineageTestRecord {
  final String id;
  final String testType;
  final String testResult;
  final double testCoverage;
  final DateTime testTimestamp;
  final String testLogPath;
  final String completionStatus;
  final double orphanRecordRate;
  final DateTime actionTimestamp;
  final String userSessionId;
  final String standardReference;

  const LineageTestRecord({
    required this.id,
    required this.testType,
    required this.testResult,
    required this.testCoverage,
    required this.testTimestamp,
    required this.testLogPath,
    required this.completionStatus,
    required this.orphanRecordRate,
    required this.actionTimestamp,
    required this.userSessionId,
    this.standardReference = 'DAMA-DMBOK2 Data Lineage & Provenance Standard',
  });

  bool get isPass => testResult.toUpperCase() == 'PASS' && orphanRecordRate <= 0.005;
  bool get isOptimal => orphanRecordRate == 0.0;
}

/// High-density data grid widget with progressive disclosure for Dataplex lineage verification.
class LineageDataGridWidget extends StatefulWidget {
  final List<LineageTestRecord>? initialRecords;
  final ValueChanged<LineageTestRecord>? onRecordSelected;

  const LineageDataGridWidget({
    super.key,
    this.initialRecords,
    this.onRecordSelected,
  });

  @override
  State<LineageDataGridWidget> createState() => _LineageDataGridWidgetState();
}

class _LineageDataGridWidgetState extends State<LineageDataGridWidget> {
  late List<LineageTestRecord> _records;
  String? _expandedRecordId;
  int _sortColumnIndex = 3;
  bool _sortAscending = false;

  @override
  void initState()
  {
    super.initState();
    _records = widget.initialRecords ?? _generateSampleRecords();
  }

  List<LineageTestRecord> _generateSampleRecords() {
    final now = DateTime.now();
    return [
      LineageTestRecord(
        id: 'EVT-7475-01',
        testType: 'Dataplex Lineage Stream',
        testResult: 'Pass',
        testCoverage: 98.5,
        testTimestamp: now.subtract(const Duration(minutes: 5)),
        testLogPath: 'gs://dataplex-lineage-logs/2025-05/stream_node_01.json',
        completionStatus: 'Pass/Fail → Best = Pass (0% orphan)',
        orphanRecordRate: 0.0,
        actionTimestamp: now.subtract(const Duration(minutes: 6)),
        userSessionId: 'sess_ops_anik_7475',
      ),
      LineageTestRecord(
        id: 'EVT-7475-02',
        testType: 'BigQuery DAG Verification',
        testResult: 'Pass',
        testCoverage: 96.0,
        testTimestamp: now.subtract(const Duration(minutes: 25)),
        testLogPath: 'gs://dataplex-lineage-logs/2025-05/stream_node_02.json',
        completionStatus: 'Pass/Fail → Best = Pass (0% orphan)',
        orphanRecordRate: 0.002,
        actionTimestamp: now.subtract(const Duration(minutes: 27)),
        userSessionId: 'sess_ops_lead_7475',
      ),
      LineageTestRecord(
        id: 'EVT-7475-03',
        testType: 'Egress Schema Transform',
        testResult: 'Fail',
        testCoverage: 84.0,
        testTimestamp: now.subtract(const Duration(hours: 1)),
        testLogPath: 'gs://dataplex-lineage-logs/2025-05/stream_fail_03.log',
        completionStatus: 'Fail (0.8% orphan rate exceeded floor)',
        orphanRecordRate: 0.008,
        actionTimestamp: now.subtract(const Duration(hours: 1, minutes: 2)),
        userSessionId: 'sess_arch_dcdf_7475',
      ),
    ];
  }

  void _toggleExpansion(String id) {
    setState(() {
      _expandedRecordId = _expandedRecordId == id ? null : id;
    });
  }

  void _showFieldDescription(BuildContext context, String fieldName, String description) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.info_outline, color: Colors.blueAccent),
                  const SizedBox(width: 8),
                  Text(
                    fieldName,
                    style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(description, style: Theme.of(ctx).textTheme.bodyMedium),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton.tonal(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.all(8.0),
      clipBehavior: Clip.antiAlias,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header with DAMA-DMBOK2 Standard & Status
          Container(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                Icon(Icons.account_tree_outlined, color: colorScheme.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dataplex Automated Lineage Graph Events',
                        style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Standard: DAMA-DMBOK2 | Target Orphan Rate: 0.0% (Floor ≤0.5%)',
                        style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Touch-optimized field info',
                  icon: const Icon(Icons.help_outline, size: 20),
                  onPressed: () => _showFieldDescription(
                    context,
                    'Data Lineage Completeness',
                    'Floor boundary: ≤0.5% orphan records. Optimal target is 0% orphan rate per DAMA-DMBOK2 standard.',
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          // High-Density Data Table
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              headingRowHeight: 40,
              dataRowMinHeight: 44,
              dataRowMaxHeight: 52,
              horizontalMargin: 12,
              columnSpacing: 16,
              headingTextStyle: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold),
              columns: [
                DataColumn(
                  label: InkWell(
                    onTap: () => _showFieldDescription(
                      context,
                      'Test Type',
                      'Identifies the streaming or batch event pipeline verifying lineage.',
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Test Type'),
                        SizedBox(width: 4),
                        Icon(Icons.info_outline, size: 14),
                      ],
                    ),
                  ),
                ),
                DataColumn(
                  label: InkWell(
                    onTap: () => _showFieldDescription(
                      context,
                      'Test Result',
                      'Lineage test assertion: Pass if orphan rate <= 0.5%, else Fail.',
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Result'),
                        SizedBox(width: 4),
                        Icon(Icons.info_outline, size: 14),
                      ],
                    ),
                  ),
                ),
                DataColumn(
                  label: const Text('Coverage'),
                  numeric: true,
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      _sortColumnIndex = columnIndex;
                      _sortAscending = ascending;
                      _records.sort((a, b) => ascending
                          ? a.testCoverage.compareTo(b.testCoverage)
                          : b.testCoverage.compareTo(a.testCoverage));
                    });
                  },
                ),
                DataColumn(
                  label: const Text('Timestamp'),
                  onSort: (columnIndex, ascending) {
                    setState(() {
                      _sortColumnIndex = columnIndex;
                      _sortAscending = ascending;
                      _records.sort((a, b) => ascending
                          ? a.testTimestamp.compareTo(b.testTimestamp)
                          : b.testTimestamp.compareTo(a.testTimestamp));
                    });
                  },
                ),
                DataColumn(
                  label: InkWell(
                    onTap: () => _showFieldDescription(
                      context,
                      'Orphan Rate',
                      'Percentage of detached graph nodes. Floor: <= 0.5%, Optimal: 0%.',
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Orphan Rate'),
                        SizedBox(width: 4),
                        Icon(Icons.info_outline, size: 14),
                      ],
                    ),
                  ),
                  numeric: true,
                ),
                const DataColumn(label: Text('Progressive Detail')),
              ],
              rows: _records.map((record) {
                final isExpanded = _expandedRecordId == record.id;
                return DataRow(
                  selected: isExpanded,
                  onSelectChanged: (_) {
                    _toggleExpansion(record.id);
                    widget.onRecordSelected?.call(record);
                  },
                  cells: [
                    DataCell(
                      Text(
                        record.testType,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: record.isPass
                              ? Colors.green.withValues(alpha: 0.15)
                              : Colors.red.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          record.testResult,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: record.isPass ? Colors.green.shade800 : Colors.red.shade800,
                          ),
                        ),
                      ),
                    ),
                    DataCell(Text('${record.testCoverage.toStringAsFixed(1)}%')),
                    DataCell(
                      Text(
                        '${record.testTimestamp.hour.toString().padLeft(2, '0')}:${record.testTimestamp.minute.toString().padLeft(2, '0')}:${record.testTimestamp.second.toString().padLeft(2, '0')}',
                      ),
                    ),
                    DataCell(
                      Text(
                        '${(record.orphanRecordRate * 100).toStringAsFixed(2)}%',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: record.orphanRecordRate <= 0.005 ? Colors.green.shade700 : Colors.red.shade700,
                        ),
                      ),
                    ),
                    DataCell(
                      IconButton(
                        icon: Icon(isExpanded ? Icons.expand_less : Icons.expand_more, size: 20),
                        tooltip: 'Toggle progressive disclosure',
                        onPressed: () => _toggleExpansion(record.id),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
          // Progressive Disclosure Expanded View
          if (_expandedRecordId != null) ...[
            const Divider(height: 1),
            Builder(builder: (context) {
              final selected = _records.firstWhere((r) => r.id == _expandedRecordId);
              return Container(
                padding: const EdgeInsets.all(14.0),
                color: colorScheme.surfaceContainerLow,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Record Audit: ${selected.id}',
                          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        Chip(
                          visualDensity: VisualDensity.compact,
                          label: Text(selected.completionStatus),
                          backgroundColor: selected.isOptimal ? Colors.green.shade50 : Colors.amber.shade50,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    _buildDetailRow('Test Log Path', selected.testLogPath, isMonospace: true),
                    _buildDetailRow('Session ID', selected.userSessionId, isMonospace: true),
                    _buildDetailRow('Action Timestamp', selected.actionTimestamp.toIso8601String()),
                    _buildDetailRow('Provenance Standard', selected.standardReference),
                  ],
                ),
              );
            }),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isMonospace = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontFamily: isMonospace ? 'monospace' : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
