// lib/models/build_artifact_lock_model.dart
// Task GEN-00370: Lock production build artifacts against unauthorized modification.

class BuildArtifactLockModel {
  final String artifactSha256;
  final bool isLocked;
  final double stateEnforcementAccuracy;
  final String securityStandard;
  final String timestamp;

  const BuildArtifactLockModel({
    required this.artifactSha256,
    required this.isLocked,
    required this.stateEnforcementAccuracy,
    required this.securityStandard,
    required this.timestamp,
  });
}
