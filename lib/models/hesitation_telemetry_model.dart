/// Represents an invisible focus tracking session on a mapped input field
class FocusTrackingSession {
  final String fieldId;
  final String fieldLabel;
  final DateTime focusStartTime;
  DateTime? focusEndTime;
  bool hesitationFlagged;

  FocusTrackingSession({
    required this.fieldId,
    required this.fieldLabel,
    required this.focusStartTime,
    this.focusEndTime,
    this.hesitationFlagged = false,
  });

  int get durationInMilliseconds {
    final end = focusEndTime ?? DateTime.now();
    return end.difference(focusStartTime).inMilliseconds;
  }

  double get durationInSeconds => durationInMilliseconds / 1000.0;
}

/// Data model tracking atomic telemetry for ISO/IEC/IEEE 29119 software testing audits
class HesitationTestTelemetryRecord {
  final String testType;
  final String testResult;
  final String testCoverage;
  final String testTimestamp;
  final String testLogPath;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  HesitationTestTelemetryRecord({
    required this.testType,
    required this.testResult,
    required this.testCoverage,
    required this.testTimestamp,
    required this.testLogPath,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
