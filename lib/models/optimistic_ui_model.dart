// lib/models/optimistic_ui_model.dart
class OptimisticUiModel {
  final double syncSuccessRate;
  final bool isOptimisticUpdateEnabled;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const OptimisticUiModel({
    required this.syncSuccessRate,
    required this.isOptimisticUpdateEnabled,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
