class ScoreEvent {
  final String metricKey;
  final double score;
  final String grade;
  final int latencyMs;

  ScoreEvent({
    required this.metricKey,
    required this.score,
    required this.grade,
    required this.latencyMs,
  });
}
