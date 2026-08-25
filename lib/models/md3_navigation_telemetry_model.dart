import 'package:flutter/foundation.dart';

/// Atomic Telemetry Record for Task 5341AEETE-019 MD3 Navigation Audits
@immutable
class Md3NavigationTelemetryRecord {
  final String layoutType;
  final String layoutGridDimensions;
  final String spacingRules;
  final String alignmentSettings;
  final String layoutValidationStatus;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const Md3NavigationTelemetryRecord({
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

/// BDD Input Field schema definition for iterative component targeting
class BddInputFieldData {
  final String fieldKey;
  final String label;
  final String initialValue;

  const BddInputFieldData({
    required this.fieldKey,
    required this.label,
    this.initialValue = '',
  });
}
