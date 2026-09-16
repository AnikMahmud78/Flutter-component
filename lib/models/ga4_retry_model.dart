// lib/models/ga4_retry_model.dart
class Ga4RetryModel {
  final int currentAttempt;
  final int maxRetryLimit;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const Ga4RetryModel({
    required this.currentAttempt,
    required this.maxRetryLimit,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
