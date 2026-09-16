// lib/models/auth_badge_model.dart
// Task GEN-00159: Secure Authentication Status Badge Component
class AuthBadgeModel {
  final String authState;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const AuthBadgeModel({
    required this.authState,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
