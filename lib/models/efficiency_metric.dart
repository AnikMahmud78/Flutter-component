class EfficiencyMetric {
  final double baselineMinutes;
  final double optimizedMinutes;

  const EfficiencyMetric({
    required this.baselineMinutes,
    required this.optimizedMinutes,
  });

  double get reductionPercentage =>
      ((baselineMinutes - optimizedMinutes) / baselineMinutes) * 100;

  bool get passesTarget => reductionPercentage >= 30.0;
}
