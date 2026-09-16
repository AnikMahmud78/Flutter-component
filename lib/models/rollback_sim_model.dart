// lib/models/rollback_sim_model.dart
class RollbackSimModel {
  final bool simulationPassed;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const RollbackSimModel({
    required this.simulationPassed,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
