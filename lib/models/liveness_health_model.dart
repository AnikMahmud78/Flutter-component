import 'package:flutter/foundation.dart';

enum ResponseHealthState { healthy, degraded, failed }

@immutable
class LivenessHealthModel {
  final String taskId;
  final int httpStatusCode;
  final double latencyMs;
  final ResponseHealthState healthState;
  final double stepCompletionRate;
  final DateTime evaluatedAt;
  final String userId;

  const LivenessHealthModel({
    required this.taskId,
    required this.httpStatusCode,
    required this.latencyMs,
    required this.healthState,
    required this.stepCompletionRate,
    required this.evaluatedAt,
    required this.userId,
  });
}
