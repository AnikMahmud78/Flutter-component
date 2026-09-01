import 'package:flutter/foundation.dart';

/// Representation of Header System Status Tracking Variables
@immutable
class HeaderSystemStatusVariables {
  final String traceId;
  final String userState;
  final String connectionState;

  const HeaderSystemStatusVariables({
    required this.traceId,
    required this.userState,
    required this.connectionState,
  });
}

/// Atomic Telemetry Record for Task 3944ANSA-013 Audits
@immutable
class PersistentHeaderStatusTelemetryRecord {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const PersistentHeaderStatusTelemetryRecord({
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
