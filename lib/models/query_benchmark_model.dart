// lib/models/query_benchmark_model.dart
class QueryBenchmarkModel {
  final double executionTimeSecs;
  final bool isWithinSlo;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const QueryBenchmarkModel({
    required this.executionTimeSecs,
    required this.isWithinSlo,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
