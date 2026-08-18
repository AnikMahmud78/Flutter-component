// Location: lib/models/execution_timer_telemetry_model.dart

/// Atomic Telemetry Record for Task 3108CTTEE-027 Asset Readiness Audits
class ExecutionTimerAssetRecord {
  final String objectType;
  final String objectLocationPath;
  final String openStatus;
  final String timestamp;
  final String fileHandleId;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  ExecutionTimerAssetRecord({
    required this.objectType,
    required this.objectLocationPath,
    required this.openStatus,
    required this.timestamp,
    required this.fileHandleId,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
