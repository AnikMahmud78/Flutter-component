import 'package:flutter/foundation.dart';

@immutable
class FPatternTelemetryRecord {
  final String importSource;
  final String importStatus;
  final String importDate;
  final String importValidation;
  final int importRecordsCount;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const FPatternTelemetryRecord({
    required this.importSource,
    required this.importStatus,
    required this.importDate,
    required this.importValidation,
    required this.importRecordsCount,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
