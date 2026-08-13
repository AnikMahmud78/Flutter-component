enum ZoneHealthState {
  activePrimary,
  standbySync,
  witnessQuorum,
  failoverDegraded,
}

/// Represents an individual Availability Zone in the HA Database Policy
class DatabaseZoneNode {
  final String zoneId;
  final String zoneRegion;
  ZoneHealthState healthState;
  final String dbEngineVersion;
  int replicationLagMs;

  DatabaseZoneNode({
    required this.zoneId,
    required this.zoneRegion,
    required this.healthState,
    this.dbEngineVersion = 'PostgreSQL 16.2 (Multi-Region HA)',
    this.replicationLagMs = 2,
  });

  bool get isPrimary => healthState == ZoneHealthState.activePrimary;
}

/// Data model tracking atomic HA policy deployment telemetry
class HaPolicyExecutionModel {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;

  HaPolicyExecutionModel({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
  });
}
