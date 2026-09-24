import 'package:flutter/foundation.dart';

@immutable
class ReviewExceptionModel {
  final String exceptionId;
  final String flaggedReason;
  final double verificationRate;

  const ReviewExceptionModel({
    required this.exceptionId,
    required this.flaggedReason,
    required this.verificationRate,
  });

  String get completionStatus {
    if (verificationRate >= 0.99) return 'Good';
    if (verificationRate >= 0.90) return 'Average';
    return 'Poor';
  }
}
