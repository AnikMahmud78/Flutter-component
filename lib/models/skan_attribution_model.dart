// lib/models/skan_attribution_model.dart
class SkanAttributionModel {
  final double estimationFitPct;
  final String fitQualityRating;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const SkanAttributionModel({
    required this.estimationFitPct,
    required this.fitQualityRating,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
