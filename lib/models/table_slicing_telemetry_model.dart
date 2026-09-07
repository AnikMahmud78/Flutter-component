import 'package:flutter/foundation.dart';

class ArraySlicer {
  const ArraySlicer._();

  static List<T> getPageSlice<T>(List<T> source, int pageIndex, int rowsPerPage) {
    if (source.isEmpty || pageIndex < 0 || rowsPerPage <= 0) return <T>[];
    final start = pageIndex * rowsPerPage;
    if (start >= source.length) return <T>[];
    final end = (start + rowsPerPage).clamp(0, source.length);
    return source.sublist(start, end);
  }
}

@immutable
class TableSlicingTelemetryRecord {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const TableSlicingTelemetryRecord({
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
