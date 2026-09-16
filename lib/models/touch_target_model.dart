// lib/models/touch_target_model.dart
// Task GEN-00092: Confirm Enforced 48dp Touch Bounds Delivery
class TouchTargetModel {
  final String packageName;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final int minTouchDp;

  const TouchTargetModel({
    required this.packageName,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    required this.minTouchDp,
  });
}
