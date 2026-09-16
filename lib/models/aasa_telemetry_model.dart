// lib/models/aasa_telemetry_model.dart
class AasaTelemetryModel {
  final String url;
  final int statusCode;
  final bool isHttpsValid;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const AasaTelemetryModel({
    required this.url,
    required this.statusCode,
    required this.isHttpsValid,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
