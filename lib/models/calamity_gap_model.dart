import 'package:flutter/foundation.dart';

enum EscalationStatus { complete, partial, notComplete }

@immutable
class CalamityGapModel {
  final String taskId;
  final String gapId;
  final String description;
  final EscalationStatus status;
  final double completionRate;
  final DateTime loggedAt;
  final String assignedLeaderId;

  const CalamityGapModel({
    required this.taskId,
    required this.gapId,
    required this.description,
    required this.status,
    required this.completionRate,
    required this.loggedAt,
    required this.assignedLeaderId,
  });
}
