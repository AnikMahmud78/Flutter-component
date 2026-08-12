/// Represents a row in the BigQuery infrastructure_performance_scorecard table
class PerformanceScorecardRecord {
  final String scorecardId;
  final String metricDate;
  final String executionTimestamp;
  final double apiLatencyP95Ms;
  final double serviceUptimePercentage;
  final double errorRatePercentage;
  final double schemaAlignmentRate; // Target: 1.0 (100%)
  final String schemaValidationStatus; // Pass / Fail

  PerformanceScorecardRecord({
    required this.scorecardId,
    required this.metricDate,
    required this.executionTimestamp,
    required this.apiLatencyP95Ms,
    required this.serviceUptimePercentage,
    required this.errorRatePercentage,
    required this.schemaAlignmentRate,
    required this.schemaValidationStatus,
  });

  bool get isFullyAligned =>
      schemaAlignmentRate == 1.0 && schemaValidationStatus == 'Pass';
}
