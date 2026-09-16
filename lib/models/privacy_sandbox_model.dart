// lib/models/privacy_sandbox_model.dart
class PrivacySandboxModel {
  final bool hasTopicsConsent;
  final bool hasFledgeConsent;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const PrivacySandboxModel({
    required this.hasTopicsConsent,
    required this.hasFledgeConsent,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
