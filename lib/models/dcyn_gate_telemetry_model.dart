import 'package:flutter/foundation.dart';

/// Atomic Telemetry Record for Task 8102BCDLD-035 Audits
@immutable
class DcynGateTelemetryRecord {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final double measuredInpMs;

  const DcynGateTelemetryRecord({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    this.measuredInpMs = 32.4, // <50ms Good INP Band
  });
}

/// Alternative Role Match for Candidate Re-funnel Carousel
class AlternativeRoleCandidate {
  final String roleId;
  final String title;
  final String skillMatchPercentage;
  final String salaryBand;

  const AlternativeRoleCandidate({
    required this.roleId,
    required this.title,
    required this.skillMatchPercentage,
    required this.salaryBand,
  });
}
