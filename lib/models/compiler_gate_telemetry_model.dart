import 'package:flutter/foundation.dart';

@immutable
class CompilerGateTelemetryRecord {
  final String configurationKey;
  final String configurationValue;
  final String configurationType;
  final String validationStatus;
  final String configurationTimestamp;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const CompilerGateTelemetryRecord({
    required this.configurationKey,
    required this.configurationValue,
    required this.configurationType,
    required this.validationStatus,
    required this.configurationTimestamp,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
