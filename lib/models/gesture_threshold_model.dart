// lib/models/gesture_threshold_model.dart
// Task GEN-00271: Approve gesture thresholds and swipe action maps for mobile queue items.

class GestureThresholdModel {
  final String taskId;
  final String taskName;
  final String completionStatus;
  final double swipeThresholdPx;
  final String actionEventTimestamp;
  final String userSessionId;

  const GestureThresholdModel({
    required this.taskId,
    required this.taskName,
    required this.completionStatus,
    required this.swipeThresholdPx,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
