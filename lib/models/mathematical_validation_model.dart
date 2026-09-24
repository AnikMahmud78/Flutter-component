import 'package:flutter/foundation.dart';

enum ValidationStatus { complete, partial, notComplete }

@immutable
class MathematicalValidationModel {
  final String taskId;
  final String traceId;
  final double valueA;
  final double valueB;
  final double delta;
  final ValidationStatus status;
  final double validationAccuracy;
  final DateTime timestamp;
  final String userId;

  const MathematicalValidationModel({
    required this.taskId,
    required this.traceId,
    required this.valueA,
    required this.valueB,
    required this.delta,
    required this.status,
    required this.validationAccuracy,
    required this.timestamp,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'task_id': taskId,
      'trace_id': traceId,
      'value_a': valueA,
      'value_b': valueB,
      'delta': delta,
      'status': status.toString().split('.').last,
      'validation_accuracy': validationAccuracy,
      'event_timestamp': timestamp.toIso8601String(),
      'user_id': userId,
    };
  }
}
