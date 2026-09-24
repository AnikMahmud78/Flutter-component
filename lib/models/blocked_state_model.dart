import 'package:flutter/foundation.dart';

enum BlockedStatus { complete, partial, notComplete }

@immutable
class BlockedStateModel {
  final String taskId;
  final String blockReason;
  final BlockedStatus status;
  final double completionRate;
  final DateTime timestamp;
  final String userId;

  const BlockedStateModel({
    required this.taskId,
    required this.blockReason,
    required this.status,
    required this.completionRate,
    required this.timestamp,
    required this.userId,
  });
}
