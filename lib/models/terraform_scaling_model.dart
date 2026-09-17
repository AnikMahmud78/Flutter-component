// lib/models/terraform_scaling_model.dart
class TerraformScalingModel {
  final int minInstances;
  final int maxInstances;
  final bool isConfigured;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const TerraformScalingModel({
    required this.minInstances,
    required this.maxInstances,
    required this.isConfigured,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
