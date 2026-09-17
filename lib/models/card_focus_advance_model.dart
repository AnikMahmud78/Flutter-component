// lib/models/card_focus_advance_model.dart
class CardFocusAdvanceModel {
  final bool isPciCompliant;
  final bool hasAutoAdvance;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const CardFocusAdvanceModel({
    required this.isPciCompliant,
    required this.hasAutoAdvance,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
