import 'package:flutter/foundation.dart';

@immutable
class CalendarSubmissionTelemetryRecord {
  final String buildStatus;
  final String buildTimestamp;
  final String buildArtifactsPath;
  final String buildLogs;
  final String buildDuration;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const CalendarSubmissionTelemetryRecord({
    required this.buildStatus,
    required this.buildTimestamp,
    required this.buildArtifactsPath,
    required this.buildLogs,
    required this.buildDuration,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
