class AbandonmentMetric {
  final double abandonmentRate;
  final String riskLevel; // High, Medium, Low
  final DateTime timestamp;

  const AbandonmentMetric({
    required this.abandonmentRate,
    required this.riskLevel,
    required this.timestamp,
  });
}
