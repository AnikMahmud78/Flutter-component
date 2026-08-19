// Location: lib/models/bulk_action_guardrail_model.dart

/// Model representing a project specification row eligible for bulk operations
class ProjectSpecificationRow {
  final String id;
  final String title;
  final String category;
  final String lastModified;
  bool isSelected;

  ProjectSpecificationRow({
    required this.id,
    required this.title,
    required this.category,
    required this.lastModified,
    this.isSelected = false,
  });
}

/// Atomic Telemetry Record for Task 3196CSIVW-012 Readiness Audits
class BulkActionGuardrailTelemetry {
  final String workspaceName;
  final String workspaceId;
  final String workspaceConfiguration;
  final String memberList;
  final String workspaceStatus;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  BulkActionGuardrailTelemetry({
    required this.workspaceName,
    required this.workspaceId,
    required this.workspaceConfiguration,
    required this.memberList,
    required this.workspaceStatus,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
