class LatencyMetric {
  final String actionName;
  final int latencyMs;
  final String rating; // 'Good', 'Average', 'Poor'

  LatencyMetric({required this.actionName, required this.latencyMs, required this.rating});
}
