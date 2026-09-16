class Material3LayoutTelemetryRecord {
  final String scaffoldType;
  final String layoutPattern;
  final String navigationRail;
  final String listDetailRule;
  final String adaptiveBreakpoint;
  final String validationStatus;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const Material3LayoutTelemetryRecord({
    required this.scaffoldType,
    required this.layoutPattern,
    required this.navigationRail,
    required this.listDetailRule,
    required this.adaptiveBreakpoint,
    required this.validationStatus,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
