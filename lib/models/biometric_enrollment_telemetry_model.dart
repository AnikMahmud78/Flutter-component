import 'package:flutter/foundation.dart';

@immutable
class BiometricEnrollmentTelemetryRecord {
  final String definitionName;
  final String definitionParameters;
  final String definitionType;
  final String validationStatus;
  final String definitionId;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const BiometricEnrollmentTelemetryRecord({
    required this.definitionName,
    required this.definitionParameters,
    required this.definitionType,
    required this.validationStatus,
    required this.definitionId,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
