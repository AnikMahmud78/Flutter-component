import 'package:flutter/foundation.dart';

enum VerificationStatus { complete, partial, notComplete }

@immutable
class UiAcknowledgementModel {
  final String taskId;
  final bool userConfirmed;
  final bool feedbackDisplayed;
  final double auditVerificationRate;
  final VerificationStatus status;
  final DateTime acknowledgedAt;
  final String userId;

  const UiAcknowledgementModel({
    required this.taskId,
    required this.userConfirmed,
    required this.feedbackDisplayed,
    required this.auditVerificationRate,
    required this.status,
    required this.acknowledgedAt,
    required this.userId,
  });
}
