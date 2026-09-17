// lib/models/cta_regex_bind_model.dart
class CtaRegexBindModel {
  final double structuralIntegrity;
  final bool isNextCtaEnabled;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const CtaRegexBindModel({
    required this.structuralIntegrity,
    required this.isNextCtaEnabled,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
