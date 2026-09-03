import 'package:flutter/foundation.dart';

/// Atomic Telemetry Record for Task 7838AWCV-016-17 Audits
@immutable
class DlqErrorAssistanceTelemetryRecord {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const DlqErrorAssistanceTelemetryRecord({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
