import 'package:flutter/foundation.dart';

@immutable
class LinterRuleModel {
  final String ruleId;
  final double detectionAccuracy;
  final int totalViolationsBlocked;

  const LinterRuleModel({
    required this.ruleId,
    required this.detectionAccuracy,
    required this.totalViolationsBlocked,
  });

  String get completionStatus => detectionAccuracy >= 0.90 ? 'Pass' : 'Fail';
}
