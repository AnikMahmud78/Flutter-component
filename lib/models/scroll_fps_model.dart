import 'package:flutter/foundation.dart';

@immutable
class ScrollFpsModel {
  final double currentFps;
  final int droppedFrames;
  final double completionRate;

  const ScrollFpsModel({
    required this.currentFps,
    required this.droppedFrames,
    required this.completionRate,
  });

  String get completionStatus {
    if (completionRate >= 99.0) return 'Complete';
    if (completionRate >= 90.0) return 'Partial';
    return 'Not Complete';
  }
}
