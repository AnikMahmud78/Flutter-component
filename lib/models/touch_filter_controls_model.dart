// lib/models/touch_filter_controls_model.dart
class TouchFilterControlsModel {
  final String applicationLatency;
  final bool areFiltersTouchFriendly;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const TouchFilterControlsModel({
    required this.applicationLatency,
    required this.areFiltersTouchFriendly,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
