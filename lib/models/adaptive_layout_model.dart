import 'package:flutter/foundation.dart';

enum ActiveLayoutMode { compact, medium, expanded }
enum LayoutStepStatus { complete, partial, notComplete }

@immutable
class AdaptiveLayoutModel {
  final String taskId;
  final ActiveLayoutMode currentMode;
  final LayoutStepStatus status;
  final double completionRate;
  final DateTime timestamp;
  final String userId;

  const AdaptiveLayoutModel({
    required this.taskId,
    required this.currentMode,
    required this.status,
    required this.completionRate,
    required this.timestamp,
    required this.userId,
  });
}
