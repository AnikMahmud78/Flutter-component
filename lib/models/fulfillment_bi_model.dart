import 'package:flutter/foundation.dart';

@immutable
class FulfillmentBiModel {
  final double avgFulfillmentHours;
  final double transitionSpeedSeconds;
  final int activeBottlenecks;

  const FulfillmentBiModel({
    required this.avgFulfillmentHours,
    required this.transitionSpeedSeconds,
    required this.activeBottlenecks,
  });

  String get completionStatus => activeBottlenecks == 0 ? 'Good' : 'Average';
}
