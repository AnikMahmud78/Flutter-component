// lib/models/dedup_table_model.dart
class DedupTableModel {
  final String tableName;
  final bool isExecuted;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const DedupTableModel({
    required this.tableName,
    required this.isExecuted,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
