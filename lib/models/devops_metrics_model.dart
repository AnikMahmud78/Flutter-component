import 'package:flutter/foundation.dart';

@immutable
class DevOpsMetricsModel {
  final double buildPassRate;
  final double complianceScore;
  final double refreshLatencyMinutes;

  const DevOpsMetricsModel({
    required this.buildPassRate,
    required this.complianceScore,
    required this.refreshLatencyMinutes,
  });

  String get completionStatus {
    if (refreshLatencyMinutes <= 5) return 'Good';
    if (refreshLatencyMinutes <= 60) return 'Average';
    return 'Poor';
  }
}
