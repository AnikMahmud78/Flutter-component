import 'package:flutter/foundation.dart';

/// Representation of Header Analytics Configuration Logging Parameters
@immutable
class HeaderAnalyticsConfigItem {
  final String configurationParameter;
  final String currentSetting;
  final String previousSetting;
  final String changeLog;
  final String configurationTimestamp;

  const HeaderAnalyticsConfigItem({
    required this.configurationParameter,
    required this.currentSetting,
    required this.previousSetting,
    required this.changeLog,
    required this.configurationTimestamp,
  });
}

/// Atomic Telemetry Record for Task 1117ANSA-012 Audits
@immutable
class HeaderAnalyticsTelemetryRecord {
  final String configurationParameter;
  final String currentSetting;
  final String previousSetting;
  final String changeLog;
  final String configurationTimestamp;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final double refreshAccuracyRate;

  const HeaderAnalyticsTelemetryRecord({
    required this.configurationParameter,
    required this.currentSetting,
    required this.previousSetting,
    required this.changeLog,
    required this.configurationTimestamp,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    this.refreshAccuracyRate = 0.999, // 99.9% Accuracy / Near Real-time
  });
}
