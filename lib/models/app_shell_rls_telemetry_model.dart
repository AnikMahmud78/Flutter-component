import 'package:flutter/foundation.dart';

/// Representation of a Departmental Access Token Payload
@immutable
class DepartmentalAccessToken {
  final String tokenId;
  final String userId;
  final List<String> authorizedDepartments;
  final DateTime expirationTimestamp;

  const DepartmentalAccessToken({
    required this.tokenId,
    required this.userId,
    required this.authorizedDepartments,
    required this.expirationTimestamp,
  });

  bool hasPrivilegeFor(String department) {
    return authorizedDepartments.contains(department) &&
        expirationTimestamp.isAfter(DateTime.now());
  }
}

/// Atomic Telemetry Record for Task 5803ANSA-008 Audits
@immutable
class AppShellRlsTelemetryRecord {
  final String validationType;
  final String validationResult;
  final String errorMessages;
  final String validationTimestamp;
  final String validationLog;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const AppShellRlsTelemetryRecord({
    required this.validationType,
    required this.validationResult,
    required this.errorMessages,
    required this.validationTimestamp,
    required this.validationLog,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
