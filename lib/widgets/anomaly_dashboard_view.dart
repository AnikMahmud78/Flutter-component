import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../models/anomaly_telemetry_model.dart';

class AnomalyDashboardView extends StatefulWidget {
  const AnomalyDashboardView({super.key});

  @override
  State<AnomalyDashboardView> createState() => _AnomalyDashboardViewState();
}

class _AnomalyDashboardViewState extends State<AnomalyDashboardView> {
  late Timer _streamTimer;
  final Random _random = Random();

  // Score Metrics
  double _globalHealthScore = 98.4;
  double _anomalyVarianceScore = 0.016;
  bool _isSystemNormal = true;

  // Monitored Nodes
  List<AssetHealthNode> _nodes = [
    AssetHealthNode(
      nodeId: 'NODE-01',
      nodeName: 'API Gateway Ingress',
      varianceScore: 0.004,
      isHealthy: true,
    ),
    AssetHealthNode(
      nodeId: 'NODE-02',
      nodeName: 'Identity Provider (IAM)',
      varianceScore: 0.002,
      isHealthy: true,
    ),
    AssetHealthNode(
      nodeId: 'NODE-03',
      nodeName: 'Pub/Sub Analytics Stream',
      varianceScore: 0.011,
      isHealthy: true,
    ),
    AssetHealthNode(
      nodeId: 'NODE-04',
      nodeName: 'Cloud Functions Engine',
      varianceScore: 0.005,
      isHealthy: true,
    ),
  ];

  // Chronological Logs
  final List<TelemetryLogEvent> _logs = [
    TelemetryLogEvent(
      logId: 'LOG-1001',
      timestamp: '00:04:12',
      message:
          'Real-time anomaly scoring stream connected to Pub/Sub endpoint.',
      severity: 'INFO',
    ),
    TelemetryLogEvent(
      logId: 'LOG-1000',
      timestamp: '00:03:58',
      message:
          'Identity Provider health check passed. 0 unauthorized accesses detected.',
      severity: 'INFO',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Simulate real-time streaming telemetry updates every 2.5 seconds
    _streamTimer = Timer.periodic(const Duration(milliseconds: 2500), (timer) {
      _simulateRealtimeTelemetry();
    });
  }

  void _simulateRealtimeTelemetry() {
    if (!mounted) return;

    setState(() {
      // Fluctuate variance score slightly
      final varianceDelta = (_random.nextDouble() * 0.01) - 0.005;
      _anomalyVarianceScore = (_anomalyVarianceScore + varianceDelta).clamp(
        0.001,
        0.250,
      );

      _isSystemNormal = _anomalyVarianceScore < 0.150;
      _globalHealthScore = _isSystemNormal
          ? (100.0 - (_anomalyVarianceScore * 100))
          : 74.2;

      // Add a live log event
      final nowStr = DateTime.now().toIso8601String().substring(11, 19);
      _logs.insert(
        0,
        TelemetryLogEvent(
          logId: 'LOG-${1000 + _logs.length}',
          timestamp: nowStr,
          message: _isSystemNormal
              ? 'Telemetry vector evaluation nominal. Variance: ${_anomalyVarianceScore.toStringAsFixed(4)}'
              : 'ANOMALY DETECTED: Variance spike observed above 0.150 threshold!',
          severity: _isSystemNormal ? 'INFO' : 'ANOMALY',
        ),
      );

      if (_logs.length > 20) {
        _logs.removeLast();
      }
    });
  }

  @override
  void dispose() {
    _streamTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-Time Anomaly Scoring'),
        backgroundColor: colorScheme.surfaceContainerHigh,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Chip(
              avatar: Icon(
                _isSystemNormal ? Icons.check_circle : Icons.warning_rounded,
                color: _isSystemNormal
                    ? Colors.green.shade700
                    : colorScheme.error,
                size: 18,
              ),
              label: Text(
                _isSystemNormal ? 'System Normal' : 'Anomaly Detected',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: _isSystemNormal
                      ? Colors.green.shade900
                      : colorScheme.onErrorContainer,
                ),
              ),
              backgroundColor: _isSystemNormal
                  ? Colors.green.shade50
                  : colorScheme.errorContainer,
              side: BorderSide(
                color: _isSystemNormal
                    ? Colors.green.shade300
                    : colorScheme.error,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =========================================================
            // 1. CLEAN SUMMARY SCORE VIEWS (M3 Dashboarding Rule)
            // =========================================================
            Text(
              'Executive Health Summary',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                // Global Health Score Card
                Expanded(
                  child: Card.filled(
                    color: colorScheme.primaryContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Global Health Score',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: colorScheme.onPrimaryContainer.withAlpha(
                                180,
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_globalHealthScore.toStringAsFixed(1)}%',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onPrimaryContainer,
                            ),
                          ),
                          const SizedBox(height: 4),
                          LinearProgressIndicator(
                            value: _globalHealthScore / 100.0,
                            backgroundColor: colorScheme.onPrimaryContainer
                                .withAlpha(30),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              _isSystemNormal
                                  ? colorScheme.primary
                                  : colorScheme.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Mathematical Variance Score Card
                Expanded(
                  child: Card.outlined(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Anomaly Variance',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _anomalyVarianceScore.toStringAsFixed(4),
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: _isSystemNormal
                                  ? colorScheme.onSurface
                                  : colorScheme.error,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Threshold: < 0.1500',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.outline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // =========================================================
            // 2. HEALTH INDICATOR MAP (Monitored IT Assets)
            // =========================================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Monitored Infrastructure Nodes',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Real-Time Vector Engine',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _nodes.length,
              itemBuilder: (context, index) {
                final node = _nodes[index];
                return Card.outlined(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.green.shade100,
                          child: Icon(
                            Icons.check,
                            size: 18,
                            color: Colors.green.shade800,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                node.nodeName,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.labelLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '${node.nodeId} • Var: ${node.varianceScore}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: colorScheme.outline,
                                  fontSize: 10,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // =========================================================
            // 3. CHRONOLOGICAL LOGGING LIST (Dense Data below Summary)
            // =========================================================
            Text(
              'Chronological Anomaly Telemetry Logs',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Card.outlined(
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _logs.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final log = _logs[index];
                  return ListTile(
                    dense: true,
                    leading: Text(
                      log.timestamp,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontFamily: 'monospace',
                        color: colorScheme.outline,
                      ),
                    ),
                    title: Text(
                      log.message,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 12,
                        color: log.severity == 'ANOMALY'
                            ? colorScheme.error
                            : colorScheme.onSurface,
                        fontWeight: log.severity == 'ANOMALY'
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: log.getSeverityColor(colorScheme).withAlpha(20),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        log.severity,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: log.getSeverityColor(colorScheme),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
