// lib/models/dlq_retry_model.dart
class DlqRetryModel {
  final int currentAttemptCount;
  final int maxRetryLimit;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const DlqRetryModel({
    required this.currentAttemptCount,
    required this.maxRetryLimit,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
