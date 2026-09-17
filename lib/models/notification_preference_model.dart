// lib/models/notification_preference_model.dart
class NotificationPreferenceModel {
  final double captureCompleteness;
  final bool isGdprCompliant;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const NotificationPreferenceModel({
    required this.captureCompleteness,
    required this.isGdprCompliant,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
