import 'package:flutter/foundation.dart';

@immutable
class DisputeBiModel {
  final int totalDisputes;
  final String topCategory;
  final int resolutionCycleHours;

  const DisputeBiModel({
    required this.totalDisputes,
    required this.topCategory,
    required this.resolutionCycleHours,
  });

  String get completionStatus {
    if (resolutionCycleHours <= 48) return 'Good';
    if (resolutionCycleHours <= 120) return 'Average';
    return 'Poor';
  }
}
