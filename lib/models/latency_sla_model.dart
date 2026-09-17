// lib/models/latency_sla_model.dart
class LatencySlaModel {
  final double averageLatencyMs;
  final bool isWithinSla;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const LatencySlaModel({
    required this.averageLatencyMs,
    required this.isWithinSla,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
