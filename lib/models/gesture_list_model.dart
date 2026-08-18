// Location: lib/models/gesture_list_model.dart

/// Represents a tabular list item supporting gesture actions
class GestureListItem {
  final String id;
  final String title;
  final String subtitle;
  final String timestamp;
  bool isArchived;
  bool isDeleted;

  GestureListItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.timestamp,
    this.isArchived = false,
    this.isDeleted = false,
  });
}

/// Atomic Telemetry Model for Task 3075BPTR-0206 Audits
class GestureAuditTelemetryRecord {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  GestureAuditTelemetryRecord({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
