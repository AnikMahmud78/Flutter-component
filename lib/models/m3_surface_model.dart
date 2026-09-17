// lib/models/m3_surface_model.dart
class M3SurfaceModel {
  final double elevationDp;
  final bool hasActiveRipples;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const M3SurfaceModel({
    required this.elevationDp,
    required this.hasActiveRipples,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
