class TokenExportModel {
  final String repositoryName;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const TokenExportModel({
    required this.repositoryName,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
