// lib/models/mtti_validation_model.dart
class MttiValidationModel {
  final int clickToInstallDeltaSecs;
  final double executionTimeMs;
  final bool isLegitimateInstall;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const MttiValidationModel({
    required this.clickToInstallDeltaSecs,
    required this.executionTimeMs,
    required this.isLegitimateInstall,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
