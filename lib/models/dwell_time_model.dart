// lib/models/dwell_time_model.dart
class DwellTimeModel {
  final double iaTaskSuccessRate;
  final int dwellTimeMs;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const DwellTimeModel({
    required this.iaTaskSuccessRate,
    required this.dwellTimeMs,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
