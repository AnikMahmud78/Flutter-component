import 'package:flutter/foundation.dart';

@immutable
class TactileFeedbackModel {
  final bool isSelected;
  final double completionRate;

  const TactileFeedbackModel({
    required this.isSelected,
    required this.completionRate,
  });

  String get completionStatus {
    if (completionRate >= 99.0) return 'Complete';
    if (completionRate >= 90.0) return 'Partial';
    return 'Not Complete';
  }
}
