// lib/models/pii_normalization_model.dart
class PiiNormalizationModel {
  final String rawEmail;
  final String normalizedEmail;
  final String hashedEmailSha256;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const PiiNormalizationModel({
    required this.rawEmail,
    required this.normalizedEmail,
    required this.hashedEmailSha256,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
