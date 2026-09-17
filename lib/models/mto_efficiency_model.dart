// lib/models/mto_efficiency_model.dart
class MtoEfficiencyModel {
  final int queueDepth;
  final double turnaroundTimeMins;
  final double dashboardLoadTimeSecs;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const MtoEfficiencyModel({
    required this.queueDepth,
    required this.turnaroundTimeMins,
    required this.dashboardLoadTimeSecs,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
