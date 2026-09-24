class BqKpiResult {
  final String eventDate;
  final String traceId;
  final double completionRate;
  final double avgLatencyMs;
  final bool isAccuracyValidated;

  BqKpiResult({
    required this.eventDate,
    required this.traceId,
    required this.completionRate,
    required this.avgLatencyMs,
    required this.isAccuracyValidated,
  });
}
