import 'package:flutter/foundation.dart';

/// Data model tracking agentic task handoff layout parameters & exception telemetry
@immutable
class AgenticHandoffTelemetry {
  final String layoutType;
  final String layoutGridDimensions;
  final String spacingRules;
  final String alignmentSettings;
  final String layoutValidationStatus;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const AgenticHandoffTelemetry({
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
