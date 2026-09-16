// lib/models/gamification_event_model.dart
class GamificationEventModel {
  final String eventName;
  final int pointsEarned;
  final int payloadSizeBytes;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const GamificationEventModel({
    required this.eventName,
    required this.pointsEarned,
    required this.payloadSizeBytes,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
