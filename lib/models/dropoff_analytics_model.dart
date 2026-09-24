import 'package:flutter/foundation.dart';

@immutable
class DropoffAnalyticsModel {
  final String stageName;
  final double dropoffRate;

  const DropoffAnalyticsModel({
    required this.stageName,
    required this.dropoffRate,
  });

  String get completionStatus => dropoffRate <= 0.05 ? 'Pass' : 'Fail';
}
