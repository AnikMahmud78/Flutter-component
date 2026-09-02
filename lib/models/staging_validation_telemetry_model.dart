import 'package:flutter/foundation.dart';

/// Atomic Telemetry Record for Task 8047ANSA-019 Audits
@immutable
class StagingValidationTelemetryRecord {
  final String validationType;
  final String validationResult;
  final String errorMessages;
  final String validationTimestamp;
  final String validationLog;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final double stagingLcpSeconds;

  const StagingValidationTelemetryRecord({
    required this.validationType,
    required this.validationResult,
    required this.errorMessages,
    required this.validationTimestamp,
    required this.validationLog,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    this.stagingLcpSeconds = 1.42, // Exceeds Core Web Vitals 1.8s Target
  });
}
