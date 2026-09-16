// lib/models/att_telemetry_model.dart
class AttTelemetryModel {
  final String trackingStatus;
  final double dialogRenderTimeMs;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const AttTelemetryModel({
    required this.trackingStatus,
    required this.dialogRenderTimeMs,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
