import 'package:flutter/foundation.dart';

@immutable
class MobileFunnelModel {
  final String funnelStage;
  final double completionRate;

  const MobileFunnelModel({
    required this.funnelStage,
    required this.completionRate,
  });

  String get completionStatus {
    if (completionRate >= 0.80) return 'Good';
    if (completionRate >= 0.60) return 'Average';
    return 'Poor';
  }
}
