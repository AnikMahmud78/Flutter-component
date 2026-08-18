// Location: lib/widgets/sparkline_dashboard_screen.dart
import 'package:flutter/material.dart';
import '../models/sparkline_telemetry_model.dart';
import 'mini_sparkline_widget.dart';

class SparklineDashboardScreen extends StatefulWidget {
  const SparklineDashboardScreen({super.key});

  @override
  State<SparklineDashboardScreen> createState() =>
      _SparklineDashboardScreenState();
}

class _SparklineDashboardScreenState extends State<SparklineDashboardScreen> {
  // Sample VAP Metric Sparkline Datasets
  final List<SparklineDataPoint> _outputTrend = const [
    SparklineDataPoint(value: 81.0, label: '08:00 AM'),
    SparklineDataPoint(value: 82.5, label: '09:00 AM'),
    SparklineDataPoint(value: 81.8, label: '10:00 AM'),
    SparklineDataPoint(value: 83.4, label: '11:00 AM'),
    SparklineDataPoint(value: 84.2, label: '12:00 PM'),
  ];

  final List<SparklineDataPoint> _alertTrend = const [
    SparklineDataPoint(value: 18.0, label: '08:00 AM'),
    SparklineDataPoint(value: 15.0, label: '09:00 AM'),
    SparklineDataPoint(value: 14.2, label: '10:00 AM'),
    SparklineDataPoint(value: 13.0, label: '11:00 AM'),
    SparklineDataPoint(value: 12.0, label: '12:00 PM'),
  ];

  SparklineAssetTelemetryRecord get _telemetry => SparklineAssetTelemetryRecord(
    objectType: 'PACKAGE_DIRECTORY',
    objectLocationPath:
        '@habot-core/mini-sparklines/lib/widgets/mini_sparkline_widget.dart',
    openStatus: 'READ_WRITE_VERIFIED',
    timestamp: DateTime.now().toUtc().toIso8601String(),
    fileHandleId: 'FH-SPARK-2026-9921',
    completionStatus: 'Complete',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-3097',
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('HABOT Mini Sparkline Engine'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(
          16.0,
        ), // HABOT 16dp page margin [cite: 45]
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ASSET READINESS AUDIT BANNER
            Card.filled(
              color: Colors.green.shade50,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.green.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.verified_user_rounded,
                      color: Colors.green.shade800,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Asset Access Readiness: Complete (100%)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.green.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Package @habot-core/mini-sparklines version-controlled & verified.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black87,
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

            Text(
              'Embedded VAP Metric Scorecards',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Slide finger along sparklines to inspect data values safely above your thumb.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),

            // HABOT VAP SCORECARD 1: UPWARD TREND (GREEN #21B373)
            _buildVapScorecard(
              context: context,
              title: 'Total VAP Output',
              headlineValue: '84.2%',
              subtext: '▲ 2.4% vs last month',
              trendColor: const Color(0xFF21B373),
              sparklineData: _outputTrend,
            ),

            const SizedBox(height: 12),

            // HABOT VAP SCORECARD 2: DOWNWARD ALERT TREND (RED #E31B23)
            _buildVapScorecard(
              context: context,
              title: 'Critical Alerts Frequency',
              headlineValue: '12 Units',
              subtext: '▼ -2.1% vs last month',
              trendColor: const Color(0xFFE31B23),
              sparklineData: _alertTrend,
            ),

            const SizedBox(height: 24),

            // ATOMIC ASSET EXECUTION TELEMETRY
            Text(
              'Atomic Asset Readability Telemetry',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Card.outlined(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  children: [
                    _buildTelemetryRow('Object Type', telemetry.objectType),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Object Path',
                      telemetry.objectLocationPath,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Open Status',
                      telemetry.openStatus,
                      isHighlight: true,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Timestamp',
                      telemetry.timestamp.substring(11, 19),
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'File Handle ID',
                      telemetry.fileHandleId,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Completion Status',
                      telemetry.completionStatus,
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

  Widget _buildVapScorecard({
    required BuildContext context,
    required String title,
    required String headlineValue,
    required String subtext,
    required Color trendColor,
    required List<SparklineDataPoint> sparklineData,
  }) {
    return Card.outlined(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          12.0,
        ), // HABOT standard rounding [cite: 126]
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          16.0,
        ), // HABOT 16dp inner padding [cite: 133]
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: trendColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    subtext,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: trendColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              headlineValue,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w900,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 12),
            MiniSparklineWidget(dataPoints: sparklineData, height: 44.0),
          ],
        ),
      ),
    );
  }

  Widget _buildTelemetryRow(
    String label,
    String value, {
    bool isHighlight = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.normal,
              color: isHighlight ? Colors.teal.shade800 : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
