import 'package:flutter/foundation.dart';

@immutable
class HesitationMonitorModel {
  final int thresholdSeconds;
  final double detectionAccuracy;
  final bool isHesitationDetected;

  const HesitationMonitorModel({
    required this.thresholdSeconds,
    required this.detectionAccuracy,
    required this.isHesitationDetected,
  });

  String get completionStatus {
    if (detectionAccuracy >= 95.0) return 'High';
    if (detectionAccuracy >= 85.0) return 'Medium';
    return 'Low';
  }
}
