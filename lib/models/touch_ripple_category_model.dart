// lib/models/touch_ripple_category_model.dart
class TouchRippleCategoryModel {
  final String timeToFind;
  final bool hasRippleFeedback;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const TouchRippleCategoryModel({
    required this.timeToFind,
    required this.hasRippleFeedback,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
