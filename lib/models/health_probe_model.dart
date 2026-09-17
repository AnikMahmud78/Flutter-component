// lib/models/health_probe_model.dart
class HealthProbeModel {
  final String fileName;
  final bool isSyntaxValid;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const HealthProbeModel({
    required this.fileName,
    required this.isSyntaxValid,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
