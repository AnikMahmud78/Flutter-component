import 'package:flutter/material.dart';
import '../models/performance_scorecard_model.dart';

class PerformanceScorecardWidget extends StatefulWidget {
  const PerformanceScorecardWidget({super.key});

  @override
  State<PerformanceScorecardWidget> createState() =>
      _PerformanceScorecardWidgetState();
}

class _PerformanceScorecardWidgetState
    extends State<PerformanceScorecardWidget> {
  bool _isQueryRunning = false;

  // Sample record fetched from BigQuery Scheduled Query execution table
  PerformanceScorecardRecord _currentScorecard = PerformanceScorecardRecord(
    scorecardId: 'SC-883921-2026',
    metricDate: '2026-08-11',
    executionTimestamp: '2026-08-12 00:05:00 UTC',
    apiLatencyP95Ms: 142.50,
    serviceUptimePercentage: 99.9820,
    errorRatePercentage: 0.0180,
    schemaAlignmentRate: 1.00,
    schemaValidationStatus: 'Pass',
  );

  void _triggerManualQueryExecution() {
    setState(() {
      _isQueryRunning = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isQueryRunning = false;
          _currentScorecard = PerformanceScorecardRecord(
            scorecardId:
                'SC-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
            metricDate: '2026-08-12',
            executionTimestamp:
                DateTime.now().toUtc().toIso8601String().substring(0, 19) +
                ' UTC',
            apiLatencyP95Ms: 138.20,
            serviceUptimePercentage: 99.9910,
            errorRatePercentage: 0.0090,
            schemaAlignmentRate: 1.00,
            schemaValidationStatus: 'Pass',
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final record = _currentScorecard;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance Scorecard Tracker'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // 16px Grid Margins
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================
            // 1. BIGQUERY SCHEMA ALIGNMENT STATUS CARD
            // =========================================================
            Card.filled(
              color: record.isFullyAligned
                  ? Colors.green.shade50
                  : colorScheme.errorContainer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: record.isFullyAligned
                      ? Colors.green.shade400
                      : colorScheme.error,
                  width: 1.5,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(
                      record.isFullyAligned
                          ? Icons.verified_rounded
                          : Icons.gpp_bad_rounded,
                      color: record.isFullyAligned
                          ? Colors.green.shade800
                          : colorScheme.error,
                      size: 32,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'BigQuery Schema Alignment: 100% (${record.schemaValidationStatus})',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: record.isFullyAligned
                                  ? Colors.green.shade900
                                  : colorScheme.onErrorContainer,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Compliant with Google BigQuery — Schema Design Best Practices.',
                            style: TextStyle(
                              fontSize: 11,
                              color: record.isFullyAligned
                                  ? Colors.green.shade800
                                  : colorScheme.onErrorContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =========================================================
            // 2. SCHEDULED QUERY CRON METADATA CARD
            // =========================================================
            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Daily BigQuery Scheduled Query',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'CRON ACTIVE',
                            style: TextStyle(
                              color: Colors.blue.shade900,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                    _buildMetaRow('Scorecard ID', record.scorecardId),
                    _buildMetaRow('Metric Aggregation Date', record.metricDate),
                    _buildMetaRow(
                      'Execution Timestamp',
                      record.executionTimestamp,
                    ),
                    _buildMetaRow(
                      'Target Table',
                      'enterprise_telemetry.infrastructure_performance_scorecard',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // =========================================================
            // 3. INFRASTRUCTURE SCORECARD KPI GRID
            // =========================================================
            Text(
              'Daily Aggregated Infrastructure Metrics',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: Card.outlined(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'p95 Latency',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${record.apiLatencyP95Ms} ms',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Card.outlined(
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Service Uptime',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${record.serviceUptimePercentage}%',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'API Error Rate (>=400)',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Target: < 0.0500%',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.blueGrey,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '${record.errorRatePercentage}%',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // =========================================================
            // 4. MANUAL TRIGGER ACTION BUTTON (>=48px Touch Target)
            // =========================================================
            SizedBox(
              width: double.infinity,
              height: 48, // >=48px Touch Target Height
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade800,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _isQueryRunning
                    ? null
                    : _triggerManualQueryExecution,
                icon: _isQueryRunning
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Icon(Icons.play_arrow_rounded),
                label: Text(
                  _isQueryRunning
                      ? 'Executing BigQuery Job...'
                      : 'Run Scheduled Query Now',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
