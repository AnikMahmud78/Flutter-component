// lib/models/deep_link_nav_model.dart
class DeepLinkNavModel {
  final String targetScreenRoute;
  final double launchSpeedMs;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const DeepLinkNavModel({
    required this.targetScreenRoute,
    required this.launchSpeedMs,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
