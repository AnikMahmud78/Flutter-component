// Location: lib/models/cypress_pipeline_telemetry_model.dart
import 'package:flutter/foundation.dart';

/// Atomic Telemetry Record for Task 14240AEETE-021 Cypress Pipeline Audits
@immutable
class CypressPipelineTelemetryRecord {
  final String testType;
  final String testResult;
  final double testCoverage;
  final String testTimestamp;
  final String testLogPath;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final String functionalTestPassRate;

  const CypressPipelineTelemetryRecord({
    required this.testType,
    required this.testResult,
    required this.testCoverage,
    required this.testTimestamp,
    required this.testLogPath,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    this.functionalTestPassRate = 'Pass (100% Target Environments + CI Regression)',
  });
}
