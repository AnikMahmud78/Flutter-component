/// Tracks individual codebase styling violations discovered during static analysis
class InlineStyleViolationItem {
  final String filePath;
  final int lineNumber;
  final String violationType; // e.g., INLINE_HARDCODED_COLOR, CUSTOM_PADDING
  final String snippet;
  bool isRemediated;

  InlineStyleViolationItem({
    required this.filePath,
    required this.lineNumber,
    required this.violationType,
    required this.snippet,
    this.isRemediated = false,
  });
}

/// Atomic Telemetry Record for Universal UI Integration Audit
class StyleAuditTelemetryRecord {
  final String auditType;
  final String auditDate;
  final String auditResult;
  final String auditTrail;
  final String auditorInformation;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  StyleAuditTelemetryRecord({
    required this.auditType,
    required this.auditDate,
    required this.auditResult,
    required this.auditTrail,
    required this.auditorInformation,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
