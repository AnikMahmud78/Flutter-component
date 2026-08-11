/// Data model tracking session lifecycle attributes and repository metadata
class SessionLifecycleModel {
  final String repositoryUrl;
  final String repositoryBranch;
  final String accessRights;
  final String commitHistory;
  final String repositoryVersion;
  final String cloneStatus;
  bool isWarningActive;
  bool isSessionExpired;

  SessionLifecycleModel({
    required this.repositoryUrl,
    required this.repositoryBranch,
    required this.accessRights,
    required this.commitHistory,
    required this.repositoryVersion,
    required this.cloneStatus,
    this.isWarningActive = false,
    this.isSessionExpired = false,
  });
}
