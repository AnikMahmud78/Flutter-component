import 'package:flutter/foundation.dart';

@immutable
class StrictInputModel {
  final String numericValue;
  final double completionRate;

  const StrictInputModel({
    required this.numericValue,
    required this.completionRate,
  });

  String get completionStatus {
    if (completionRate >= 99.0) return 'Complete';
    if (completionRate >= 90.0) return 'Partial';
    return 'Not Complete';
  }
}
