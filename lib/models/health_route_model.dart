// lib/models/health_route_model.dart
class HealthRouteModel {
  final String routePath;
  final int httpStatusCode;
  final double routeLatencyMs;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const HealthRouteModel({
    required this.routePath,
    required this.httpStatusCode,
    required this.routeLatencyMs,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
