// Location: lib/widgets/fault_tolerant_dashboard_screen.dart
import 'package:flutter/material.dart';
import '../models/error_boundary_telemetry_model.dart';
import 'mobile_error_boundary_widget.dart';

class FaultTolerantDashboardScreen extends StatefulWidget {
  const FaultTolerantDashboardScreen({super.key});

  @override
  State<FaultTolerantDashboardScreen> createState() =>
      _FaultTolerantDashboardScreenState();
}

class _FaultTolerantDashboardScreenState
    extends State<FaultTolerantDashboardScreen> {
  bool _simulateWidgetACrash = false;
  bool _simulateWidgetBCrash = false;

  final ErrorBoundaryTelemetryRecord _telemetry = ErrorBoundaryTelemetryRecord(
    mobilePlatform: 'Flutter Mobile / Android Runtime',
    osVersion: 'Android 15 (API 35)',
    deviceType: 'Enterprise Handheld / Pixel 8',
    screenDimensions: '412 x 892 dp (4-Col Grid)',
    mobileConfiguration: 'ERROR_BOUNDARY_CONTAINERS_ACTIVE',
    completionStatus: 'Complete',
    actionEventTimestamp: DateTime.now().toUtc().toIso8601String(),
    userSessionId: 'SESS-2026-ANIK-3207',
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final telemetry = _telemetry;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Viewport Error Boundary'),
        backgroundColor: colorScheme.surfaceContainerHigh,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), // Standard 16dp page margin
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ASSET & COMPONENT DISCOVERY COMPLETENESS BANNER
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
                      Icons.verified_rounded,
                      color: Colors.green.shade800,
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Discovery Completeness: Complete (100%)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: Colors.green.shade900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Package @habot-core/error-boundaries confirmed & version-controlled.',
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

            const SizedBox(height: 16),

            // SIMULATION CRASH CONTROLS
            Text(
              'Fault Tolerance Fault Test Triggers',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Simulate isolated component crashes to test error boundary containment.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 48.0),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red.shade800,
                        side: BorderSide(color: Colors.red.shade300),
                      ),
                      onPressed: () {
                        setState(() => _simulateWidgetACrash = true);
                      },
                      child: const Text('CRASH_PANEL_A'),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 48.0),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red.shade800,
                        side: BorderSide(color: Colors.red.shade300),
                      ),
                      onPressed: () {
                        setState(() => _simulateWidgetBCrash = true);
                      },
                      child: const Text('CRASH_PANEL_B'),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ISOLATED COMPONENT 1: METRIC CARD A
            Text(
              'Isolated Dashboard Panel A',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            MobileErrorBoundary(
              componentId: 'PANEL_VAP_METRIC_A',
              onResetCache: () {
                setState(() => _simulateWidgetACrash = false);
              },
              child: _buildMetricCard(
                title: 'Pipeline Ingestion Throughput',
                value: '14,250 msg/s',
                subtext: 'Optimal operational baseline',
                color: Colors.teal.shade800,
                shouldCrash: _simulateWidgetACrash,
              ),
            ),

            const SizedBox(height: 16),

            // ISOLATED COMPONENT 2: METRIC CARD B
            Text(
              'Isolated Dashboard Panel B',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            MobileErrorBoundary(
              componentId: 'PANEL_VAP_METRIC_B',
              onResetCache: () {
                setState(() => _simulateWidgetBCrash = false);
              },
              child: _buildMetricCard(
                title: 'Database Sync Latency',
                value: '18.4 ms',
                subtext: '100% within SLA limits',
                color: Colors.indigo.shade800,
                shouldCrash: _simulateWidgetBCrash,
              ),
            ),

            const SizedBox(height: 24),

            // ATOMIC AUDIT TELEMETRY LOG
            Text(
              'Atomic Step Execution Telemetry',
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
                    _buildTelemetryRow(
                      'Mobile Platform',
                      telemetry.mobilePlatform,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow('OS Version', telemetry.osVersion),
                    const Divider(height: 12),
                    _buildTelemetryRow('Device Type', telemetry.deviceType),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Screen Dimensions',
                      telemetry.screenDimensions,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Mobile Config',
                      telemetry.mobileConfiguration,
                    ),
                    const Divider(height: 12),
                    _buildTelemetryRow(
                      'Completion Status',
                      telemetry.completionStatus,
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

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtext,
    required Color color,
    required bool shouldCrash,
  }) {
    if (shouldCrash) {
      // Intentional simulation error trigger
      throw Exception('SIMULATED_COMPONENT_RENDER_CRASH_EXCEPTION');
    }

    return Card.outlined(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                fontFamily: 'monospace',
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtext,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
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
              color: isHighlight ? Colors.green.shade800 : Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
