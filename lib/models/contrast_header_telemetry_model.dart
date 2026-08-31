import 'package:flutter/foundation.dart';

/// Atomic Telemetry Record for Task 281ANSA-012 Audits
@immutable
class ContrastHeaderTelemetryRecord {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final double measuredContrastRatio;

  const ContrastHeaderTelemetryRecord({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    this.measuredContrastRatio = 7.1, // WCAG AAA Compliant (7:1 Target)
  });
}
