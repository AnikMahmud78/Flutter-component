import 'package:flutter/foundation.dart';

/// Representation of M3 Adaptive Component Import Records
@immutable
class M3AdaptiveImportRecord {
  final String importSource;
  final String importStatus;
  final String importDate;
  final String importValidation;
  final int importRecordsCount;

  const M3AdaptiveImportRecord({
    required this.importSource,
    required this.importStatus,
    required this.importDate,
    required this.importValidation,
    required this.importRecordsCount,
  });
}

/// Atomic Telemetry Record for Task 3834ANSA-020-03 Audits
@immutable
class M3AdaptiveImportTelemetryRecord {
  final String importSource;
  final String importStatus;
  final String importDate;
  final String importValidation;
  final int importRecordsCount;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const M3AdaptiveImportTelemetryRecord({
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
