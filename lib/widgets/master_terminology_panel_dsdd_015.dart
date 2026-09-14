// DSDD-015 — Master Terminology Dictionary Setup for Unified UI Mapping.
// Enforces Material 3 typographic scale uniformity, fail-closed least-privilege role masking, and BigQuery-aligned observability telemetry logging.

import 'package:flutter/material.dart';

/// Completion status classification aligned with OpenTelemetry & GCP Observability standards.
enum ObservabilityStatus {
  high('High'),
  medium('Medium'),
  low('Low');

  final String label;
  const ObservabilityStatus(this.label);
}

/// System telemetry payload structured for BigQuery ingestion.
class TelemetryLogEvent {
  final String frontendTechnology;
  final String frameworkVersion;
  final String buildConfiguration;
  final String buildOutputPath;
  final double observabilityCoverageRate;
  final ObservabilityStatus completionStatus;
  final DateTime timestamp;
  final String userSessionId;
  final Map<String, dynamic> performanceMetrics;

  const TelemetryLogEvent({
    required this.frontendTechnology,
    required this.frameworkVersion,
    required this.buildConfiguration,
    required this.buildOutputPath,
    required this.observabilityCoverageRate,
    required this.completionStatus,
    required this.timestamp,
    required this.userSessionId,
    required this.performanceMetrics,
  });

  Map<String, dynamic> toBigQueryRow() => {
        'frontend_technology': frontendTechnology,
        'framework_version': frameworkVersion,
        'build_configuration': buildConfiguration,
        'build_output_path': buildOutputPath,
        'observability_coverage_rate': observabilityCoverageRate,
        'completion_status': completionStatus.label,
        'timestamp': timestamp.toIso8601String(),
        'user_session_id': userSessionId,
        'performance_metrics': performanceMetrics,
      };
}

/// Mapping definition linking human-facing UI labels to backend logging keys.
class TerminologyToken {
  final String tokenKey;
  final String uiDisplayTerm;
  final String backendLogKey;
  final String md3TypeScaleName;
  final Set<String> authorizedRoles;
  final String bigQueryColumn;

  const TerminologyToken({
    required this.tokenKey,
    required this.uiDisplayTerm,
    required this.backendLogKey,
    required this.md3TypeScaleName,
    required this.authorizedRoles,
    required this.bigQueryColumn,
  });
}

/// Master terminology dictionary registry for unified UI mapping.
class MasterTerminologyDictionary {
  static const List<TerminologyToken> tokens = [
    TerminologyToken(
      tokenKey: 'frontend_tech',
      uiDisplayTerm: 'Frontend Technology',
      backendLogKey: 'fe_tech_stack',
      md3TypeScaleName: 'titleMedium',
      authorizedRoles: {'Systems Governance Specialist', 'Lead Architect', 'Operations Lead'},
      bigQueryColumn: 'frontend_technology',
    ),
    TerminologyToken(
      tokenKey: 'framework_ver',
      uiDisplayTerm: 'Framework Version',
      backendLogKey: 'flutter_framework_version',
      md3TypeScaleName: 'bodyLarge',
      authorizedRoles: {'Systems Governance Specialist', 'Lead Architect', 'Operations Lead'},
      bigQueryColumn: 'framework_version',
    ),
    TerminologyToken(
      tokenKey: 'build_config',
      uiDisplayTerm: 'Build Configuration',
      backendLogKey: 'build_mode_env',
      md3TypeScaleName: 'bodyMedium',
      authorizedRoles: {'Systems Governance Specialist', 'Operations Lead'},
      bigQueryColumn: 'build_configuration',
    ),
    TerminologyToken(
      tokenKey: 'perf_metrics',
      uiDisplayTerm: 'Performance Metrics',
      backendLogKey: 'runtime_fps_latency',
      md3TypeScaleName: 'labelLarge',
      authorizedRoles: {'Systems Governance Specialist', 'Operations Lead'},
      bigQueryColumn: 'performance_metrics',
    ),
    TerminologyToken(
      tokenKey: 'build_out_path',
      uiDisplayTerm: 'Build Output Path',
      backendLogKey: 'artifact_distribution_path',
      md3TypeScaleName: 'bodySmall',
      authorizedRoles: {'Lead Architect', 'Operations Lead'},
      bigQueryColumn: 'build_output_path',
    ),
  ];

  /// Fail-closed role verification (Poka-Yoke mistake proofing).
  static bool isFieldPermitted(TerminologyToken token, String activeUserRole) {
    return token.authorizedRoles.contains(activeUserRole);
  }
}

/// Responsive Master Terminology Administration and Observability Widget.
class MasterTerminologyPanelDsdd015 extends StatefulWidget {
  final String userRole;
  final String userSessionId;
  final ValueChanged<TelemetryLogEvent>? onTelemetryDispatched;

  const MasterTerminologyPanelDsdd015({
    super.key,
    required this.userRole,
    required this.userSessionId,
    this.onTelemetryDispatched,
  });

  @override
  State<MasterTerminologyPanelDsdd015> createState() =>
      _MasterTerminologyPanelDsdd015State();
}

class _MasterTerminologyPanelDsdd015State
    extends State<MasterTerminologyPanelDsdd015> {
  static const double floorBoundary = 0.95;
  static const double optimalTarget = 1.0;
  static const double ceilingBoundary = 1.0;

  late final Map<String, TextEditingController> _controllers;
  double _currentCoverageRate = optimalTarget;

  @override
  void initState() {
    super.initState();
    _controllers = {
      'frontend_tech': TextEditingController(text: 'Flutter MD3 UI Engine'),
      'framework_ver': TextEditingController(text: '3.29.x (Dart SDK 3.7)'),
      'build_config': TextEditingController(text: 'Production - Event-Driven Mobile'),
      'perf_metrics': TextEditingController(text: '60 FPS / Latency < 16ms'),
      'build_out_path': TextEditingController(text: 'build/app/outputs/flutter-apk/release.apk'),
    };
  }

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  ObservabilityStatus _calculateStatus(double coverage) {
    if (coverage >= optimalTarget) return ObservabilityStatus.high;
    if (coverage >= floorBoundary) return ObservabilityStatus.medium;
    return ObservabilityStatus.low;
  }

  void _dispatchTelemetry() {
    final status = _calculateStatus(_currentCoverageRate);
    final payload = TelemetryLogEvent(
      frontendTechnology: _controllers['frontend_tech']?.text ?? 'Unknown',
      frameworkVersion: _controllers['framework_ver']?.text ?? 'Unknown',
      buildConfiguration: _controllers['build_config']?.text ?? 'Unknown',
      buildOutputPath: _controllers['build_out_path']?.text ?? 'Unknown',
      observabilityCoverageRate: _currentCoverageRate,
      completionStatus: status,
      timestamp: DateTime.now().toUtc(),
      userSessionId: widget.userSessionId,
      performanceMetrics: {
        'raw_entry': _controllers['perf_metrics']?.text ?? '',
        'render_coverage': _currentCoverageRate,
        'boundary_floor': floorBoundary,
        'boundary_optimal': optimalTarget,
        'boundary_ceiling': ceilingBoundary,
      },
    );

    widget.onTelemetryDispatched?.call(payload);
  }

  TextStyle _resolveMd3TextStyle(BuildContext context, String typeScaleName) {
    final textTheme = Theme.of(context).textTheme;
    switch (typeScaleName) {
      case 'titleMedium':
        return textTheme.titleMedium ?? const TextStyle(fontSize: 16, fontWeight: FontWeight.w600);
      case 'bodyLarge':
        return textTheme.bodyLarge ?? const TextStyle(fontSize: 16);
      case 'bodyMedium':
        return textTheme.bodyMedium ?? const TextStyle(fontSize: 14);
      case 'labelLarge':
        return textTheme.labelLarge ?? const TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
      case 'bodySmall':
      default:
        return textTheme.bodySmall ?? const TextStyle(fontSize: 12);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final status = _calculateStatus(_currentCoverageRate);

    final visibleTokens = MasterTerminologyDictionary.tokens
        .where((token) => MasterTerminologyDictionary.isFieldPermitted(token, widget.userRole))
        .toList();

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Terminology & Telemetry Governance',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Role: ${widget.userRole} (Fail-Closed Perimeter)',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
                Chip(
                  label: Text(
                    'Status: ${status.label}',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: status == ObservabilityStatus.high
                          ? theme.colorScheme.onPrimaryContainer
                          : theme.colorScheme.onErrorContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: status == ObservabilityStatus.high
                      ? theme.colorScheme.primaryContainer
                      : theme.colorScheme.errorContainer,
                ),
              ],
            ),
            const Divider(height: 28),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _MetricIndicator(
                    label: 'Floor',
                    value: '$floorBoundary',
                  ),
                  _MetricIndicator(
                    label: 'Optimal',
                    value: '$optimalTarget',
                  ),
                  _MetricIndicator(
                    label: 'Current Coverage',
                    value: '${(_currentCoverageRate * 100).toStringAsFixed(1)}%',
                    highlight: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (visibleTokens.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(
                    'No permitted control fields for current operational role.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: visibleTokens.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final token = visibleTokens[index];
                  final controller = _controllers[token.tokenKey];
                  final tokenStyle = _resolveMd3TextStyle(context, token.md3TypeScaleName);

                  return TextField(
                    controller: controller,
                    style: tokenStyle,
                    decoration: InputDecoration(
                      labelText: token.uiDisplayTerm,
                      helperText: 'Mapped to BigQuery: ${token.bigQueryColumn} (Log: ${token.backendLogKey})',
                      helperStyle: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 10,
                        color: theme.colorScheme.secondary,
                      ),
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: theme.colorScheme.surface,
                    ),
                  );
                },
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _currentCoverageRate = (_currentCoverageRate == 1.0) ? 0.94 : 1.0;
                    });
                  },
                  child: const Text('Toggle Boundary Rate'),
                ),
                const SizedBox(width: 12),
                FilledButton.icon(
                  onPressed: _dispatchTelemetry,
                  icon: const Icon(Icons.cloud_upload_outlined),
                  label: const Text('Sync Telemetry'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MetricIndicator extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;

  const _MetricIndicator({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.outline,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: highlight ? theme.colorScheme.primary : theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}
