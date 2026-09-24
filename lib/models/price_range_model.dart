import 'package:flutter/foundation.dart';

@immutable
class PriceRangeModel {
  final double minPrice;
  final double maxPrice;
  final int latencyMs;

  const PriceRangeModel({
    required this.minPrice,
    required this.maxPrice,
    required this.latencyMs,
  });

  String get completionStatus {
    if (latencyMs <= 300) return 'Good';
    if (latencyMs <= 1000) return 'Average';
    return 'Poor';
  }
}
