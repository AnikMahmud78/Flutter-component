class DependencyVerificationModel {
  final String predecessorStep;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const DependencyVerificationModel({
    required this.predecessorStep,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
