class NetworkSyncTelemetry {
  final String syncType;
  final String syncStatus;
  final String lastSyncDate;
  final int syncConflicts;
  final int syncDurationMs;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const NetworkSyncTelemetry({
    required this.syncType,
    required this.syncStatus,
    required this.lastSyncDate,
    required this.syncConflicts,
    required this.syncDurationMs,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
