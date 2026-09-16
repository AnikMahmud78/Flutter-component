// lib/models/date_mask_model.dart
// Task GEN-00068: Schema-Driven Input Mask Props for Date Types
class DateMaskModel {
  final String fieldKey;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final double enforcementRate;

  const DateMaskModel({
    required this.fieldKey,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    required this.enforcementRate,
  });
}
