// Location: lib/models/tablet_rail_telemetry_model.dart

/// Atomic Telemetry Record for Task 3130TNRML-004 Tablet Rail Audits
class TabletRailAuditTelemetry {
  final String architecturePattern;
  final String componentHierarchy;
  final String dataFlowDiagram;
  final String integrationPoints;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  TabletRailAuditTelemetry({
    required this.architecturePattern,
    required this.componentHierarchy,
    required this.dataFlowDiagram,
    required this.integrationPoints,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
