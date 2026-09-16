// lib/models/insight_time_model.dart
class InsightTimeModel {
  final double renderTimeSecs;
  final bool isWithinTarget;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const InsightTimeModel({
    required this.renderTimeSecs,
    required this.isWithinTarget,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
