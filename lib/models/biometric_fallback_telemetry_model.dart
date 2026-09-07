import 'package:flutter/foundation.dart';

@immutable
class BiometricFallbackTelemetryRecord {
  final String accessType;
  final String userRole;
  final String permissionLevel;
  final String accessLog;
  final String accessTimestamp;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const BiometricFallbackTelemetryRecord({
    required this.accessType,
    required this.userRole,
    required this.permissionLevel,
    required this.accessLog,
    required this.accessTimestamp,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
