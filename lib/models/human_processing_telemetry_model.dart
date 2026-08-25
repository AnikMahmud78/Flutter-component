// Location: lib/models/human_processing_telemetry_model.dart
import 'package:flutter/foundation.dart';

/// Representation of a dynamic data configuration item loaded into templates
@immutable
class DynamicLayoutConfigItem {
  final String configKey;
  final String configValue;
  final String configType;
  final String validationStatus;
  final String configTimestamp;

  const DynamicLayoutConfigItem({
    required this.configKey,
    required this.configValue,
    required this.configType,
    required this.validationStatus,
    required this.configTimestamp,
  });
}

/// Atomic Telemetry Record for Task 7706AEETE-031-16 Audits
@immutable
class HumanProcessingTelemetryRecord {
  final String configurationKey;
  final String configurationValue;
  final String configurationType;
  final String validationStatus;
  final String configurationTimestamp;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final double qaTestCasePassRate;

  const HumanProcessingTelemetryRecord({
    required this.configurationKey,
    required this.configurationValue,
    required this.configurationType,
    required this.validationStatus,
    required this.configurationTimestamp,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    this.qaTestCasePassRate = 1.0, // 100% QA Test Case Pass Rate
  });
}
