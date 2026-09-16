// lib/models/auth_badge_telemetry.dart
// Task GEN-00159 (revised): Secure Authentication Status Badge Component
class AuthBadgeTelemetry {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final double presentationConformanceScore;

  const AuthBadgeTelemetry({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    required this.presentationConformanceScore,
  });
}
