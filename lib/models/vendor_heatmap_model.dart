// lib/models/vendor_heatmap_model.dart
class VendorHeatmapModel {
  final double rageClickDetectionAccuracy;
  final bool isHeatmapRendered;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const VendorHeatmapModel({
    required this.rageClickDetectionAccuracy,
    required this.isHeatmapRendered,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
