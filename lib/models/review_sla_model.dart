import 'package:flutter/foundation.dart';

@immutable
class ReviewSLAModel {
  final String reviewId;
  final String riskLevel;
  final DateTime createdAt;
  final int slaMinutes;
  final double verificationScore;

  const ReviewSLAModel({
    required this.reviewId,
    required this.riskLevel,
    required this.createdAt,
    this.slaMinutes = 5,
    required this.verificationScore,
  });

  int get remainingSeconds {
    final expiryTime = createdAt.add(Duration(minutes: slaMinutes));
    final diff = expiryTime.difference(DateTime.now()).inSeconds;
    return diff > 0 ? diff : 0;
  }

  bool get isBreached => remainingSeconds == 0;

  String get completionStatus {
    if (verificationScore >= 0.99) return 'Good';
    if (verificationScore >= 0.90) return 'Average';
    return 'Poor';
  }
}
