// Location: lib/models/unit_test_telemetry_model.dart
import 'package:flutter/foundation.dart';

/// Atomic Telemetry Record for Task 7288AEETE-019-A15 Unit Test Audits
@immutable
class UnitTestTelemetryRecord {
  final String testType;
  final String testResult;
  final double testCoverage;
  final String testTimestamp;
  final String testLogPath;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const UnitTestTelemetryRecord({
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
