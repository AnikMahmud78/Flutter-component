import 'dart:async';
import 'package:flutter/material.dart';
import '../models/audit_latency_model.dart';

class AuditLatencyWidget extends StatefulWidget {
  const AuditLatencyWidget({super.key});

  @override
  State<AuditLatencyWidget> createState() => _AuditLatencyWidgetState();
}

class _AuditLatencyWidgetState extends State<AuditLatencyWidget> {
  final TextEditingController _latencyLimitController = TextEditingController(
    text: '200',
  );
  final TextEditingController _queryPathController = TextEditingController(
    text: 'enterprise_telemetry.realtime_ingress',
  );

  bool _isSyncing = false;
  int _activeLatencyMs = 124;
  Timer? _syncTimer;

  AuditLatencyModel get _currentRecord => AuditLatencyModel(
    stepExecutionId: 'EXEC-1612EDEBS-2026',
    executionStatus: _isSyncing ? 'SYNCHRONIZING' : 'PASS',
    executionTimestamp: DateTime.now().toUtc().toIso8601String(),
    stepOutcome: 'Data Flow Audit Latency Limits Configured',
    userId: 'ANIK-BIGQUERY-ARCHITECT',
    currentLatencyMs: _activeLatencyMs,
    maxLatencyLimitMs: int.tryParse(_latencyLimitController.text) ?? 200,
    isSyncing: _isSyncing,
  );

  @override
  void dispose() {
    _latencyLimitController.dispose();
    _queryPathController.dispose();
    _syncTimer?.cancel();
    super.dispose();
  }

  void _triggerDataSync() {
    setState(() {
      _isSyncing = true;
    });

    // Simulate BigQuery data flow audit sync latency evaluation
    _syncTimer = Timer(const Duration(milliseconds: 1200), () {
      if (mounted) {
        setState(() {
          _isSyncing = false;
          _activeLatencyMs = 118; // Updated synced latency
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Data Flow Audit Synchronized Successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final record = _currentRecord;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Flow Audit Latency Limits'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        // REQUIREMENT: Strict 8dp Grid Layout (16dp outer padding)
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================
            // 1. MATERIAL DESIGN 3 BADGE TIMER DISPLAY ELEMENT
            // =========================================================
            Card.filled(
              color: colorScheme.surfaceContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: BorderSide(color: colorScheme.outlineVariant),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0), // 16dp Grid Margin
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Audit Latency Threshold',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 4.0), // 4dp Grid Gap
                        Text(
                          '${record.currentLatencyMs} ms',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: record.isWithinLimit
                                ? colorScheme.primary
                                : colorScheme.error,
                          ),
                        ),
                      ],
                    ),

                    // REQUIREMENT: Apply Material Design 3 Badge styling to timer element
                    Badge(
                      backgroundColor: record.isWithinLimit
                          ? colorScheme.tertiaryContainer
                          : colorScheme.errorContainer,
                      textColor: record.isWithinLimit
                          ? colorScheme.onTertiaryContainer
                          : colorScheme.onErrorContainer,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 6.0,
                      ),
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            record.isWithinLimit
                                ? Icons.timer_outlined
                                : Icons.warning_amber_rounded,
                            size: 14.0,
                            color: record.isWithinLimit
                                ? colorScheme.onTertiaryContainer
                                : colorScheme.onErrorContainer,
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            'Limit: ${record.maxLatencyLimitMs}ms',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24.0), // 24dp Grid Increment
            // =========================================================
            // 2. OUTLINED INPUT FORMS (Strict 8dp Grid Layout)
            // =========================================================
            Text(
              'Audit Configuration Parameters',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12.0),

            // INPUT 1: Latency Limit (Outlined)
            TextFormField(
              controller: _latencyLimitController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Max Latency Limit (ms)',
                hintText: 'Enter limit in milliseconds',
                border: const OutlineInputBorder(), // Clear border guidelines
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colorScheme.primary,
                    width: 2.0,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 14.0,
                ),
              ),
              onChanged: (_) => setState(() {}),
            ),

            const SizedBox(height: 16.0), // 16dp Grid Increment
            // INPUT 2: BigQuery Target Table (Outlined)
            TextFormField(
              controller: _queryPathController,
              decoration: InputDecoration(
                labelText: 'BigQuery Data Flow Endpoint',
                hintText: 'dataset.table_name',
                border: const OutlineInputBorder(), // Clear border guidelines
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: colorScheme.primary,
                    width: 2.0,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 14.0,
                ),
              ),
            ),

            const SizedBox(height: 24.0),

            // =========================================================
            // 3. DYNAMIC LOADING ANIMATION & ACTION BUTTON
            // =========================================================
            SizedBox(
              width: double.infinity,
              height: 48.0, // Minimum 48dp Touch Target
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  foregroundColor: colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: _isSyncing ? null : _triggerDataSync,
                icon: _isSyncing
                    ? SizedBox(
                        width: 18.0,
                        height: 18.0,
                        child: CircularProgressIndicator(
                          color: colorScheme.onPrimary,
                          strokeWidth: 2.0,
                        ),
                      )
                    : const Icon(Icons.sync_rounded),
                label: Text(
                  _isSyncing
                      ? 'Synchronizing Data Flow Audit...'
                      : 'Trigger Audit Data Sync',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 24.0),

            // =========================================================
            // 4. FLUID VERTICAL LIST (Structural Field Data Hierarchies)
            // =========================================================
            Text(
              'Audit Execution Hierarchy',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(16.0), // 16dp Grid Padding
                child: Column(
                  children: [
                    _buildHierarchyRow(
                      'Step Execution ID',
                      record.stepExecutionId,
                    ),
                    const Divider(height: 16.0),
                    _buildHierarchyRow(
                      'Execution Status',
                      record.executionStatus,
                      isBadge: true,
                    ),
                    const Divider(height: 16.0),
                    _buildHierarchyRow(
                      'Execution Timestamp',
                      record.executionTimestamp,
                    ),
                    const Divider(height: 16.0),
                    _buildHierarchyRow('Step Outcome', record.stepOutcome),
                    const Divider(height: 16.0),
                    _buildHierarchyRow('User / Sign-off ID', record.userId),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHierarchyRow(
    String label,
    String value, {
    bool isBadge = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: isBadge
              ? Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 2.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: Colors.green.shade300),
                    ),
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade900,
                      ),
                    ),
                  ),
                )
              : Text(
                  value,
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ],
    );
  }
}
