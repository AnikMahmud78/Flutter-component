/// Represents the local mathematical balance calculation state (A - B = 0)
class BalanceCalculationState {
  double valueA; // Ingestion Target / Debits
  double valueB; // Allocated Payload / Credits

  BalanceCalculationState({
    this.valueA = 5000.00,
    this.valueB = 4200.00, // Initial variance = 800.00
  });

  /// Computes the exact variance (A - B)
  double get variance => valueA - valueB;

  /// Evaluates whether the A - B = 0 condition is strictly satisfied
  bool get isBalanced => variance.abs() < 0.0001;
}

/// Data model tracking atomic step execution telemetry for audit compliance
class BalanceExecutionTelemetry {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;

  BalanceExecutionTelemetry({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
  });
}
