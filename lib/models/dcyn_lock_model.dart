/// Represents the DCYN validation state and hard-lock verification parameters
class DcynLockState {
  final String recordId;
  final bool hasDcynFailure;
  final String failureReason;
  final String payloadData;

  DcynLockState({
    required this.recordId,
    required this.hasDcynFailure,
    required this.failureReason,
    required this.payloadData,
  });
}

/// Data model tracking atomic step execution telemetry for ISO 9001:2015 audits
class DcynAuditTelemetry {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;

  DcynAuditTelemetry({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
  });
}
