// Location: lib/models/master_shell_telemetry_model.dart

/// Atomic Telemetry Record for Task 3119ANSA-014 Scaffolding Audits
class MasterShellAuditTelemetry {
  final String architecturePattern;
  final String componentHierarchy;
  final String dataFlowDiagram;
  final String integrationPoints;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  MasterShellAuditTelemetry({
    required this.architecturePattern,
    required this.componentHierarchy,
    required this.dataFlowDiagram,
    required this.integrationPoints,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
