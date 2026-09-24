import 'package:flutter/foundation.dart';

enum UnmountState { complete, partial, notComplete }

@immutable
class VirtualNodeModel {
  final String taskId;
  final int activeNodesInMemory;
  final int unmountedNodesCount;
  final UnmountState status;
  final double completionRate;
  final DateTime timestamp;
  final String sessionUser;

  const VirtualNodeModel({
    required this.taskId,
    required this.activeNodesInMemory,
    required this.unmountedNodesCount,
    required this.status,
    required this.completionRate,
    required this.timestamp,
    required this.sessionUser,
  });
}
