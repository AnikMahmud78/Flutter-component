import 'package:flutter/foundation.dart';

@immutable
class AvailabilityBadgeModel {
  final String statusText;
  final bool isAvailable;
  final double accuracy;

  const AvailabilityBadgeModel({
    required this.statusText,
    required this.isAvailable,
    required this.accuracy,
  });

  String get completionStatus => accuracy >= 0.95 ? 'Pass' : 'Fail';
}
