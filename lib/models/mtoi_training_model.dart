/// Tracks video playback state and un-gating validation for MTOI modules
class MtoiTrainingState {
  final String videoId;
  final String videoTitle;
  bool isVideoCompleted;
  String operatorFeedback;

  MtoiTrainingState({
    required this.videoId,
    required this.videoTitle,
    this.isVideoCompleted = false,
    this.operatorFeedback = '',
  });
}

/// Data model tracking atomic telemetry for DORA deployment audits
class MtoiAuditTelemetry {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;

  MtoiAuditTelemetry({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
  });
}
