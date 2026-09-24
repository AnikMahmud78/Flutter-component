import 'package:flutter/foundation.dart';

@immutable
class DeepLinkHandoffModel {
  final String linkUrl;
  final String targetPlatform;
  final double handoffLatencyMs;
  final double pinAccuracyMeters;

  const DeepLinkHandoffModel({
    required this.linkUrl,
    required this.targetPlatform,
    required this.handoffLatencyMs,
    required this.pinAccuracyMeters,
  });

  String get completionStatus {
    if (pinAccuracyMeters <= 10 && handoffLatencyMs <= 500) return 'Good';
    if (pinAccuracyMeters <= 50 && handoffLatencyMs <= 2000) return 'Average';
    return 'Poor';
  }
}
