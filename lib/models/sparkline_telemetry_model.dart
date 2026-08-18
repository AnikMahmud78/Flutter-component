// Location: lib/models/sparkline_telemetry_model.dart

/// Data point model for mini sparkline arrays
class SparklineDataPoint {
  final double value;
  final String label;

  const SparklineDataPoint({required this.value, required this.label});
}

/// Atomic Telemetry Record for Task 3097TTMAC-015 Asset Readiness Audits
class SparklineAssetTelemetryRecord {
  final String objectType;
  final String objectLocationPath;
  final String openStatus;
  final String timestamp;
  final String fileHandleId;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  SparklineAssetTelemetryRecord({
    required this.objectType,
    required this.objectLocationPath,
    required this.openStatus,
    required this.timestamp,
    required this.fileHandleId,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
