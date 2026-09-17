// lib/models/special_requirements_model.dart
class SpecialRequirementsModel {
  final double captureAccuracy;
  final bool isFieldRendered;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const SpecialRequirementsModel({
    required this.captureAccuracy,
    required this.isFieldRendered,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
