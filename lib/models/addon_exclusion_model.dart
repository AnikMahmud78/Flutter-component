// lib/models/addon_exclusion_model.dart
class AddonExclusionModel {
  final double attachRate;
  final bool hasConflictResolution;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const AddonExclusionModel({
    required this.attachRate,
    required this.hasConflictResolution,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
