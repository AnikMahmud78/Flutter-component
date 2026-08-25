import 'package:flutter/foundation.dart';

@immutable
class PrintPreviewTelemetryRecord {
  final String layoutType;
  final String layoutGridDimensions;
  final String spacingRules;
  final String alignmentSettings;
  final String layoutValidationStatus;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const PrintPreviewTelemetryRecord({
    required this.layoutType,
    required this.layoutGridDimensions,
    required this.spacingRules,
    required this.alignmentSettings,
    required this.layoutValidationStatus,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}