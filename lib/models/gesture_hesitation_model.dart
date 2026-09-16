// lib/models/gesture_hesitation_model.dart
// Task GEN-00103: Gesture Hesitation Tracking Engine
class GestureHesitationModel {
  final String trackerType;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final int eventCount;

  const GestureHesitationModel({
    required this.trackerType,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    required this.eventCount,
  });
}
