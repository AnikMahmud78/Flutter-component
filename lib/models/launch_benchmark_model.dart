import 'package:flutter/foundation.dart';

@immutable
class LaunchBenchmarkModel {
  final int renderTimeMs;
  final DateTime benchmarkTime;

  const LaunchBenchmarkModel({
    required this.renderTimeMs,
    required this.benchmarkTime,
  });

  String get completionStatus {
    if (renderTimeMs <= 100) return 'Good';
    if (renderTimeMs <= 300) return 'Average';
    return 'Poor';
  }
}
