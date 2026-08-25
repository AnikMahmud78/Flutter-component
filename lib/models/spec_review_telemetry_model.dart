// Location: lib/models/spec_review_telemetry_model.dart
import 'package:flutter/foundation.dart';

/// Atomic Telemetry Record for Task 14295AEETE-020-A15 Spec Review Audits
@immutable
class SpecReviewTelemetryRecord {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final double scopeCoverageCompleteness;

  const SpecReviewTelemetryRecord({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    this.scopeCoverageCompleteness = 1.0, // 100% Audit Coverage
  });
}
