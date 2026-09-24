import 'package:flutter/foundation.dart';

@immutable
class ProgressiveDisclosureModel {
  final bool isExpanded;
  final double prRejectionRate;

  const ProgressiveDisclosureModel({
    required this.isExpanded,
    required this.prRejectionRate,
  });

  String get completionStatus {
    if (prRejectionRate >= 99.0) return 'High';
    if (prRejectionRate >= 95.0) return 'Medium';
    return 'Low';
  }
}
