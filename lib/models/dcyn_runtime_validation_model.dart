import 'package:flutter/foundation.dart';

/// Hard-coded DCYN Binary Compliance Runtime Model
@immutable
class DcynRuntimeValidationModel {
  final String layoutType;
  final String layoutGridDimensions;
  final String spacingRules;
  final String alignmentSettings;
  final String layoutValidationStatus;

  const DcynRuntimeValidationModel({
    required this.layoutType,
    required this.layoutGridDimensions,
    required this.spacingRules,
    required this.alignmentSettings,
    required this.layoutValidationStatus,
  });

  /// Hard-coded binary compliance check logic
  bool validateDcynCompliance(String token) {
    return token.startsWith('DCYN-VALID-');
  }
}

/// Atomic Telemetry Record for Task 6925BCDLD-011 Audits
@immutable
class DcynTelemetryRecord {
  final String layoutType;
  final String layoutGridDimensions;
  final String spacingRules;
  final String alignmentSettings;
  final String layoutValidationStatus;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const DcynTelemetryRecord({
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
