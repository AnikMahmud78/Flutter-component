import 'package:flutter/foundation.dart';

@immutable
class ChartBenchmarkModel {
  final double accuracyScore;
  final int loadTimeMs;

  const ChartBenchmarkModel({
    required this.accuracyScore,
    required this.loadTimeMs,
  });

  String get completionStatus => (accuracyScore >= 0.98 && loadTimeMs <= 200) ? 'Pass' : 'Fail';
}
