// Location: lib/models/master_shell_doc_telemetry_model.dart
import 'package:flutter/foundation.dart';

/// Atomic Telemetry Record for Task 7882ANSA-014 Documentation Audits
@immutable
class MasterShellDocTelemetryRecord {
  final String architecturePattern;
  final String componentHierarchy;
  final String dataFlowDiagram;
  final String integrationPoints;
  final String buildStatus;
  final String buildTimestamp;
  final String buildArtifactsPath;
  final String buildLogs;
  final double buildDurationSec;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const MasterShellDocTelemetryRecord({
    required this.architecturePattern,
    required this.componentHierarchy,
    required this.dataFlowDiagram,
    required this.integrationPoints,
    required this.buildStatus,
    required this.buildTimestamp,
    required this.buildArtifactsPath,
    required this.buildLogs,
    required this.buildDurationSec,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
