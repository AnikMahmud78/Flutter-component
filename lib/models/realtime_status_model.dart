import 'package:flutter/foundation.dart';

@immutable
class RealTimeStatusModel {
  final String dispatchId;
  final int latencyMs;
  final DateTime timestamp;

  const RealTimeStatusModel({
    required this.dispatchId,
    required this.latencyMs,
    required this.timestamp,
  });

  String get completionStatus {
    if (latencyMs <= 200) return 'Good';
    if (latencyMs <= 500) return 'Average';
    return 'Poor';
  }
}
