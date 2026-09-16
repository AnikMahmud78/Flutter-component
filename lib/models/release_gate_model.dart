// lib/models/release_gate_model.dart
class ReleaseGateModel {
  final double reconciliationScore;
  final bool isReleaseAllowed;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const ReleaseGateModel({
    required this.reconciliationScore,
    required this.isReleaseAllowed,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
