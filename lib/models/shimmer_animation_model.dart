// lib/models/shimmer_animation_model.dart
class ShimmerAnimationModel {
  final int animationRefreshRateFps;
  final bool isGpuAccelerated;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const ShimmerAnimationModel({
    required this.animationRefreshRateFps,
    required this.isGpuAccelerated,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
