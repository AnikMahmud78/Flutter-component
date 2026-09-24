import 'package:flutter/foundation.dart';

@immutable
class CommercialAnalyticsModel {
  final double walletSharePercentage;
  final String topSpendCategory;
  final double refreshLatencyMinutes;

  const CommercialAnalyticsModel({
    required this.walletSharePercentage,
    required this.topSpendCategory,
    required this.refreshLatencyMinutes,
  });

  String get completionStatus {
    if (refreshLatencyMinutes <= 5) return 'Good';
    if (refreshLatencyMinutes <= 60) return 'Average';
    return 'Poor';
  }
}
