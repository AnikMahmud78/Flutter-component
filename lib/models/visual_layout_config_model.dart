// Location: lib/models/visual_layout_config_model.dart
import 'package:flutter/foundation.dart';

/// Representation of a dynamic layout configuration entry
@immutable
class DynamicLayoutConfigEntry {
  final String configurationKey;
  final String configurationValue;
  final String configurationType;
  final String validationStatus;
  final String configurationTimestamp;

  const DynamicLayoutConfigEntry({
    required this.configurationKey,
    required this.configurationValue,
    required this.configurationType,
    required this.validationStatus,
    required this.configurationTimestamp,
  });
}

/// Atomic Telemetry Record for Task 7706AEETE-031-16 Audits
@immutable
class VisualLayoutTelemetryRecord {
  final String configurationKey;
  final String configurationValue;
  final String configurationType;
  final String validationStatus;
  final String configurationTimestamp;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final double qaTestCasePassRate;

  const VisualLayoutTelemetryRecord({
    required this.configurationKey,
    required this.configurationValue,
    required this.configurationType,
    required this.validationStatus,
    required this.configurationTimestamp,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    this.qaTestCasePassRate = 1.0, // 100% Pass Rate
  });
}
