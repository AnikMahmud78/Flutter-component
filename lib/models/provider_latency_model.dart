import 'package:flutter/foundation.dart';

@immutable
class ProviderLatencyModel {
  final String providerId;
  final double responseSlaMinutes;
  final double engagementRate;
  final DateTime lastRefreshed;

  const ProviderLatencyModel({
    required this.providerId,
    required this.responseSlaMinutes,
    required this.engagementRate,
    required this.lastRefreshed,
  });

  String get completionStatus {
    final diff = DateTime.now().difference(lastRefreshed).inMinutes;
    if (diff <= 5) return 'Good';
    if (diff <= 60) return 'Average';
    return 'Poor';
  }
}
