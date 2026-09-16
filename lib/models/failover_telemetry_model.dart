// lib/models/failover_telemetry_model.dart
class FailoverTelemetryModel {
  final double failoverDurationSecs;
  final String targetZone;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const FailoverTelemetryModel({
    required this.failoverDurationSecs,
    required this.targetZone,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
