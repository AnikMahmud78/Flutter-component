// lib/models/review_sentiment_model.dart
class ReviewSentimentModel {
  final int scheduleIntervalHours;
  final bool isWorkerActive;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const ReviewSentimentModel({
    required this.scheduleIntervalHours,
    required this.isWorkerActive,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
