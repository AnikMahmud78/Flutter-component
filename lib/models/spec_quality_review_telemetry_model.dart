// Location: lib/models/spec_quality_review_telemetry_model.dart
import 'package:flutter/foundation.dart';

/// Atomic Telemetry Record for Task 14306AEETE-020-A19 Spec Uniformity Audits
@immutable
class SpecQualityReviewTelemetry {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final String codeReviewRigor;

  const SpecQualityReviewTelemetry({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    this.codeReviewRigor = 'Pass (Two Senior Approvals + Automated Scans)',
  });
}
