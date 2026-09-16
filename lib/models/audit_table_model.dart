// lib/models/audit_table_model.dart
class AuditTableModel {
  final String tableName;
  final bool isExecuted;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const AuditTableModel({
    required this.tableName,
    required this.isExecuted,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
