import 'package:flutter/foundation.dart';

/// Atomic Telemetry Record for Task 7618ANSA-019 Audits
@immutable
class IntegrationTestTelemetryRecord {
  final String testType;
  final String testResult;
  final double testCoverage;
  final String testTimestamp;
  final String testLogPath;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const IntegrationTestTelemetryRecord({
    required this.testType,
    required this.testResult,
    required this.testCoverage,
    required this.testTimestamp,
    required this.testLogPath,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
