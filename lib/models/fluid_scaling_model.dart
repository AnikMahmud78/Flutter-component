import 'package:flutter/foundation.dart';

enum ScalingStatus { complete, partial, notComplete }

@immutable
class FluidScalingModel {
  final String taskId;
  final double viewportWidth;
  final double computedFontSize;
  final ScalingStatus status;
  final double completionRate;
  final DateTime timestamp;
  final String userId;

  const FluidScalingModel({
    required this.taskId,
    required this.viewportWidth,
    required this.computedFontSize,
    required this.status,
    required this.completionRate,
    required this.timestamp,
    required this.userId,
  });
}
