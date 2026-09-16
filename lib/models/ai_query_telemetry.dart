// lib/models/ai_query_telemetry.dart
class AiQueryTelemetry {
  final String promptText;
  final double cacCalculated;
  final double bqCacActual;
  final bool isMatch;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const AiQueryTelemetry({
    required this.promptText,
    required this.cacCalculated,
    required this.bqCacActual,
    required this.isMatch,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
