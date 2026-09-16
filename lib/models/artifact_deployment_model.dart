// lib/models/artifact_deployment_model.dart
// Task GEN-00057: Google Artifact Registry Publication Engine
class ArtifactDeploymentModel {
  final String packageName;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final String registryUri;

  const ArtifactDeploymentModel({
    required this.packageName,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    required this.registryUri,
  });
}
