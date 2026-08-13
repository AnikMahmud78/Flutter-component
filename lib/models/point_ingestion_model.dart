/// Represents atomic audit configuration and telemetry for the Micro-Achievement Ingestion Engine
class PointIngestionAuditRecord {
  final String configurationParameter;
  final String currentSetting;
  final String previousSetting;
  final String changeLog;
  final String configurationTimestamp;

  PointIngestionAuditRecord({
    required this.configurationParameter,
    required this.currentSetting,
    required this.previousSetting,
    required this.changeLog,
    required this.configurationTimestamp,
  });
}

/// Loyalty Account Balance State Model
class LoyaltyAccountState {
  int balancePoints;
  int previousPoints;
  int lifetimePoints;

  LoyaltyAccountState({
    this.balancePoints = 1100,
    this.previousPoints = 1100,
    this.lifetimePoints = 4250,
  });

  void ingestPoints(int points) {
    previousPoints = balancePoints;
    balancePoints += points;
    lifetimePoints += points;
  }
}