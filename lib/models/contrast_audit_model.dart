import 'package:flutter/foundation.dart';

enum AuditStatus { complete, partial, notComplete }

@immutable
class ContrastAuditModel {
  final String taskId;
  final double contrastRatio;
  final bool isInvertedState;
  final AuditStatus status;
  final double completionRate;
  final DateTime auditedAt;
  final String inspectorId;

  const ContrastAuditModel({
    required this.taskId,
    required this.contrastRatio,
    required this.isInvertedState,
    required this.status,
    required this.completionRate,
    required this.auditedAt,
    required this.inspectorId,
  });
}
