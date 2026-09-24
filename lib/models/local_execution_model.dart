import 'package:flutter/foundation.dart';

enum ExecutionState { complete, partial, notComplete }

@immutable
class LocalExecutionModel {
  final String taskId;
  final bool executedLocally;
  final double executionTimeMs;
  final ExecutionState status;
  final double completionRate;
  final DateTime timestamp;
  final String userId;

  const LocalExecutionModel({
    required this.taskId,
    required this.executedLocally,
    required this.executionTimeMs,
    required this.status,
    required this.completionRate,
    required this.timestamp,
    required this.userId,
  });
}
