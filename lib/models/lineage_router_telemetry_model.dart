import 'package:flutter/foundation.dart';

/// Atomic Telemetry Record for Task 5396BCDLD-047 Audits
@immutable
class LineageRouterTelemetryRecord {
  final String configurationParameter;
  final String currentSetting;
  final String previousSetting;
  final String changeLog;
  final String configurationTimestamp;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const LineageRouterTelemetryRecord({
    required this.configurationParameter,
    required this.currentSetting,
    required this.previousSetting,
    required this.changeLog,
    required this.configurationTimestamp,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
