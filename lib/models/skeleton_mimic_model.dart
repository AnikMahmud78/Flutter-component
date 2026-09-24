import 'package:flutter/foundation.dart';

@immutable
class SkeletonMimicModel {
  final bool isLoading;
  final double completionRate;

  const SkeletonMimicModel({
    required this.isLoading,
    required this.completionRate,
  });

  String get completionStatus {
    if (completionRate >= 99.0) return 'Complete';
    if (completionRate >= 90.0) return 'Partial';
    return 'Not Complete';
  }
}
