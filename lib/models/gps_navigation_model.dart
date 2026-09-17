// lib/models/gps_navigation_model.dart
class GpsNavigationModel {
  final String mapLoadAccuracy;
  final bool isNativeAppLaunched;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const GpsNavigationModel({
    required this.mapLoadAccuracy,
    required this.isNativeAppLaunched,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
