// lib/models/outlier_filter_model.dart
class OutlierFilterModel {
  final int recordsFilteredCount;
  final bool isCleansePrecise;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const OutlierFilterModel({
    required this.recordsFilteredCount,
    required this.isCleansePrecise,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
