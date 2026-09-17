// lib/models/spend_pacing_model.dart
class SpendPacingModel {
  final double budgetEscalationPercent;
  final bool isAlertDispatched;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const SpendPacingModel({
    required this.budgetEscalationPercent,
    required this.isAlertDispatched,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
