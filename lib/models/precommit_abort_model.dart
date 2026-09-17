// lib/models/precommit_abort_model.dart
class PrecommitAbortModel {
  final double abortReliabilityPercent;
  final bool isHookActive;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const PrecommitAbortModel({
    required this.abortReliabilityPercent,
    required this.isHookActive,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
