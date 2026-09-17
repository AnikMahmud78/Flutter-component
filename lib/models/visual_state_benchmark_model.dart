// lib/models/visual_state_benchmark_model.dart
class VisualStateBenchmarkModel {
  final double persistenceReliability;
  final int visualUpdateMs;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const VisualStateBenchmarkModel({
    required this.persistenceReliability,
    required this.visualUpdateMs,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
