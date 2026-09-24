import 'package:flutter/foundation.dart';

@immutable
class TaskTimeGateModel {
  final int maxTaskSeconds;
  final int elapsedSeconds;
  final double prRejectionRate;

  const TaskTimeGateModel({
    required this.maxTaskSeconds,
    required this.elapsedSeconds,
    required this.prRejectionRate,
  });

  bool get isTimeExceeded => elapsedSeconds > maxTaskSeconds;

  String get completionStatus {
    if (prRejectionRate >= 99.0) return 'High';
    if (prRejectionRate >= 95.0) return 'Medium';
    return 'Low';
  }
}
