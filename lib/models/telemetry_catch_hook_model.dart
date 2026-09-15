import 'package:flutter/foundation.dart';

@immutable
class TelemetryCatchHookRecord {
  final String metricName;
  final String metricValue;
  final String monitoringStatus;
  final String alertThreshold;
  final String monitoringTimestamp;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const TelemetryCatchHookRecord({
    required this.metricName,
    required this.metricValue,
    required this.monitoringStatus,
    required this.alertThreshold,
    required this.monitoringTimestamp,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
