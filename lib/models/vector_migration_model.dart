import 'package:flutter/foundation.dart';

enum MigrationStatus { complete, partial, notComplete }

@immutable
class VectorMigrationModel {
  final String taskId;
  final int totalBitmapsReplaced;
  final double payloadSavedKb;
  final MigrationStatus status;
  final double completionRate;
  final DateTime auditedAt;
  final String inspectorId;

  const VectorMigrationModel({
    required this.taskId,
    required this.totalBitmapsReplaced,
    required this.payloadSavedKb,
    required this.status,
    required this.completionRate,
    required this.auditedAt,
    required this.inspectorId,
  });
}
