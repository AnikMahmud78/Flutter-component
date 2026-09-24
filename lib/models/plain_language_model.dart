import 'package:flutter/foundation.dart';

enum LanguageAuditStatus { complete, partial, notComplete }

@immutable
class PlainLanguageModel {
  final String taskId;
  final String sampleText;
  final double readabilityScore;
  final bool satisfiesMd3Guidelines;
  final LanguageAuditStatus status;
  final double completionRate;
  final DateTime auditedAt;
  final String userId;

  const PlainLanguageModel({
    required this.taskId,
    required this.sampleText,
    required this.readabilityScore,
    required this.satisfiesMd3Guidelines,
    required this.status,
    required this.completionRate,
    required this.auditedAt,
    required this.userId,
  });
}
