/// Data model tracking Admin Panel Application source repository discovery telemetry
class AdminRepoTelemetry {
  final String repositoryUrl;
  final String repositoryBranch;
  final String accessRights;
  final String commitHistory;
  final String repositoryVersion;
  final String cloneStatus;
  final double discoveryCompleteness; // Target: 1.0 (100%)
  final String completionStatus; // Complete

  AdminRepoTelemetry({
    this.repositoryUrl = 'https://github.com/enterprise/admin-panel-core.git',
    this.repositoryBranch = 'main',
    this.accessRights = 'READ_WRITE_SECURITY_ADMIN',
    this.commitHistory =
        'c2041a0 (Task IS42 Encapsulated Workspace Viewport Setup)',
    this.repositoryVersion = 'v4.1.0-ADMIN-CORE',
    this.cloneStatus = 'CLONED_AND_VERIFIED',
    this.discoveryCompleteness = 1.0,
    this.completionStatus = 'Complete',
  });
}

/// Task Payload Model fetched via Temporary Signed Target Link
class EncapsulatedTaskPayload {
  final String taskId;
  final String temporarySignedLink;
  final String systemInstructionLine; // System Behavior Language
  final String evidenceCardTitle;
  final String evidenceCardValue;
  final String targetFieldKey;

  EncapsulatedTaskPayload({
    required this.taskId,
    required this.temporarySignedLink,
    required this.systemInstructionLine,
    required this.evidenceCardTitle,
    required this.evidenceCardValue,
    required this.targetFieldKey,
  });
}
