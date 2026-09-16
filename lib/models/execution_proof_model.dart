class ExecutionProofModel {
  final String stepRequirement;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const ExecutionProofModel({
    required this.stepRequirement,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
