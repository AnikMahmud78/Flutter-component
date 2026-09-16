// lib/models/error_telemetry_payload.dart
class ErrorTelemetryPayload {
  final String errorStackString;
  final String failedComponentId;
  final String deviceInfo;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final int ingestionLatencyMs;

  const ErrorTelemetryPayload({
    required this.errorStackString,
    required this.failedComponentId,
    required this.deviceInfo,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    required this.ingestionLatencyMs,
  });
}
