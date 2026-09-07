import 'package:flutter/foundation.dart';

@immutable
class LeadConversionListenerTelemetryRecord {
  final String versionNumber;
  final String versionType;
  final String releaseDate;
  final String versionStatus;
  final String versionChecksum;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const LeadConversionListenerTelemetryRecord({
    required this.versionNumber,
    required this.versionType,
    required this.releaseDate,
    required this.versionStatus,
    required this.versionChecksum,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
