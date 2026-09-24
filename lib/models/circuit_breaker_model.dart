class CircuitBreakerModel {
  final double errorRatePercentage;
  final double thresholdPercentage;
  final int windowMinutes;
  final String circuitState; // CLOSED, OPEN, HALF_OPEN
  final String completionStatus;

  CircuitBreakerModel({
    required this.errorRatePercentage,
    required this.thresholdPercentage,
    required this.windowMinutes,
    required this.circuitState,
    required this.completionStatus,
  });

  Map<String, dynamic> toJson() => {
        'error_rate_percentage': errorRatePercentage,
        'threshold_percentage': thresholdPercentage,
        'window_minutes': windowMinutes,
        'circuit_state': circuitState,
        'completion_status': completionStatus,
      };
}
