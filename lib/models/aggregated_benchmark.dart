import 'package:flutter/material.dart';

/// Represents a corporate benchmark metric record from the analytical star-schema dataset
class AggregatedBenchmark {
  final String id;
  final String metricName;
  final double currentValue;
  final double targetValue;
  final String unit;
  final Color statusColor;

  AggregatedBenchmark({
    required this.id,
    required this.metricName,
    required this.currentValue,
    required this.targetValue,
    required this.unit,
    required this.statusColor,
  });

  double get progressRatio => (currentValue / targetValue).clamp(0.0, 1.0);
  int get progressPercentage => (progressRatio * 100).round();
}
