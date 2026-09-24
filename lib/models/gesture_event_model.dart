import 'package:flutter/foundation.dart';

@immutable
class GestureEventModel {
  final String lastGesture;
  final double detectionAccuracy;

  const GestureEventModel({
    required this.lastGesture,
    required this.detectionAccuracy,
  });

  String get completionStatus {
    if (detectionAccuracy >= 0.95) return 'Good';
    if (detectionAccuracy >= 0.85) return 'Average';
    return 'Poor';
  }
}
