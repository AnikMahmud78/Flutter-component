import 'package:flutter/foundation.dart';

@immutable
class ActivityLogPackageModel {
  final String moduleId;
  final double completenessScore;

  const ActivityLogPackageModel({
    required this.moduleId,
    required this.completenessScore,
  });

  String get completionStatus {
    if (completenessScore >= 0.999) return 'Complete';
    if (completenessScore >= 0.95) return 'Partial';
    return 'Not Complete';
  }
}
