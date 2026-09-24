import 'package:flutter/foundation.dart';

@immutable
class CatalogBiMetricsModel {
  final String dashboardId;
  final double bounceRatePercentage;
  final double avgTabDwellTimeSeconds;
  final DateTime lastRefreshed;

  const CatalogBiMetricsModel({
    required this.dashboardId,
    required this.bounceRatePercentage,
    required this.avgTabDwellTimeSeconds,
    required this.lastRefreshed,
  });

  String get completionStatus {
    final diff = DateTime.now().difference(lastRefreshed).inMinutes;
    if (diff <= 5) return 'Good';
    if (diff <= 60) return 'Average';
    return 'Poor';
  }
}
