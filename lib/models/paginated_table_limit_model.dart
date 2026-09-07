import 'package:flutter/foundation.dart';

@immutable
class DatasetRecord {
  final String recordId;
  final String entityName;
  final String category;
  final double metricValue;
  final DateTime timestamp;

  const DatasetRecord({
    required this.recordId,
    required this.entityName,
    required this.category,
    required this.metricValue,
    required this.timestamp,
  });
}

@immutable
class PaginatedTableLimitTelemetryRecord {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const PaginatedTableLimitTelemetryRecord({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
