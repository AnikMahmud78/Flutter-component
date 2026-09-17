// lib/models/deferred_deep_link_model.dart
class DeferredDeepLinkModel {
  final double captureRatePercent;
  final bool isContextPreserved;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const DeferredDeepLinkModel({
    required this.captureRatePercent,
    required this.isContextPreserved,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
