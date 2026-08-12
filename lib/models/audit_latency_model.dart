/// Data model tracking Data Flow Audit Latency and Step Execution telemetry
class AuditLatencyModel {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;
  final int currentLatencyMs;
  final int maxLatencyLimitMs;
  final bool isSyncing;

  AuditLatencyModel({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.currentLatencyMs,
    required this.maxLatencyLimitMs,
    this.isSyncing = false,
  });

  bool get isWithinLimit => currentLatencyMs <= maxLatencyLimitMs;
}
