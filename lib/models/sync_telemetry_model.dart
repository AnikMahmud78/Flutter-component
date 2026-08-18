/// Data model tracking atomic sync execution telemetry
class SyncTelemetryRecord {
  final String syncType;
  final String syncStatus;
  final String lastSyncDate;
  final int syncConflicts;
  final String syncDuration;

  SyncTelemetryRecord({
    required this.syncType,
    required this.syncStatus,
    required this.lastSyncDate,
    required this.syncConflicts,
    required this.syncDuration,
  });
}

/// System audit telemetry record for IIBA BABOK v3 compliance
class BabokAuditTelemetry {
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  BabokAuditTelemetry({
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
