// lib/models/anomaly_rule_model.dart
class AnomalyRuleModel {
  final double spendVariancePct;
  final int detectionTimeMins;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const AnomalyRuleModel({
    required this.spendVariancePct,
    required this.detectionTimeMins,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
