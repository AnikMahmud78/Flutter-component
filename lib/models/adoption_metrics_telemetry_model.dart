import 'package:flutter/foundation.dart';

@immutable
class AdoptionMetricsTelemetryRecord {
  final String configurationParameter;
  final String currentSetting;
  final String previousSetting;
  final String changeLog;
  final String configurationTimestamp;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const AdoptionMetricsTelemetryRecord({
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
