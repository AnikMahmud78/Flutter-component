// lib/models/release_record_model.dart
class ReleaseRecordModel {
  final String recordId;
  final String targetTable;
  final bool isCommitted;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const ReleaseRecordModel({
    required this.recordId,
    required this.targetTable,
    required this.isCommitted,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
