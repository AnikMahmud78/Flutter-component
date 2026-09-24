import 'package:flutter/foundation.dart';

enum SubtextState { complete, partial, notComplete }

@immutable
class FieldSubtextModel {
  final String taskId;
  final String fieldId;
  final String actionableSubtext;
  final SubtextState status;
  final double completionRate;
  final DateTime timestamp;
  final String userId;

  const FieldSubtextModel({
    required this.taskId,
    required this.fieldId,
    required this.actionableSubtext,
    required this.status,
    required this.completionRate,
    required this.timestamp,
    required this.userId,
  });
}
