// Location: lib/models/error_boundary_telemetry_model.dart

/// Atomic Telemetry Record for Task 3207IS20-FEBFL-020-AS01 Audits
class ErrorBoundaryTelemetryRecord {
  final String mobilePlatform;
  final String osVersion;
  final String deviceType;
  final String screenDimensions;
  final String mobileConfiguration;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  ErrorBoundaryTelemetryRecord({
    required this.mobilePlatform,
    required this.osVersion,
    required this.deviceType,
    required this.screenDimensions,
    required this.mobileConfiguration,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}

/// Data model tracking client-side crash telemetry logs
class ComponentCrashLog {
  final String componentId;
  final String errorMessage;
  final String stackTraceSnippet;
  final DateTime timestamp;

  ComponentCrashLog({
    required this.componentId,
    required this.errorMessage,
    required this.stackTraceSnippet,
    required this.timestamp,
  });
}
