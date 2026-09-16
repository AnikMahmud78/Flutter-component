class ErrorPositioningLogModel {
  final String validationType;
  final String validationResult;
  final List<String> errorMessages;
  final String validationTimestamp;
  final String validationLog;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const ErrorPositioningLogModel({
    required this.validationType,
    required this.validationResult,
    required this.errorMessages,
    required this.validationTimestamp,
    required this.validationLog,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
