// Location: lib/models/source_diff_telemetry_model.dart

/// Model representing source truth vs extracted input comparison
class SourceDiffRecord {
  final String recordId;
  final String fieldName;
  final String sourceValue;
  final String inputValue;
  final List<String> predefinedResolutions;
  bool isReconciled;
  String? selectedResolution;

  SourceDiffRecord({
    required this.recordId,
    required this.fieldName,
    required this.sourceValue,
    required this.inputValue,
    required this.predefinedResolutions,
    this.isReconciled = false,
    this.selectedResolution,
  });
}

/// Atomic Telemetry Record for Task 3141SSELC-019 Audits
class SourceDiffAuditTelemetry {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  SourceDiffAuditTelemetry({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
