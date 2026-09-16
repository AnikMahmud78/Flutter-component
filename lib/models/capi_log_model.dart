// lib/models/capi_log_model.dart
class CapiLogModel {
  final String eventId;
  final double emqScore;
  final String deduplicationStatus;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const CapiLogModel({
    required this.eventId,
    required this.emqScore,
    required this.deduplicationStatus,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
