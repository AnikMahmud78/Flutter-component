import 'package:flutter/foundation.dart';

/// Atomic Telemetry Record for Task 8201AWCV-009 Audits
@immutable
class CandidateProfileStatusTelemetryRecord {
  final String creationDate;
  final String createdBy;
  final String creationMethod;
  final String initialConfiguration;
  final String objectId;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const CandidateProfileStatusTelemetryRecord({
    required this.creationDate,
    required this.createdBy,
    required this.creationMethod,
    required this.initialConfiguration,
    required this.objectId,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
