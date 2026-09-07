import 'package:flutter/foundation.dart';

@immutable
class AtomicButtonTelemetryRecord {
  final String themeName;
  final String themeColorPalette;
  final String themeConfiguration;
  final String themeApplicationStatus;
  final String sourceElementId;
  final String targetElementId;
  final String mappingRule;
  final String mappingStatus;
  final String mappingValidation;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const AtomicButtonTelemetryRecord({
    required this.themeName,
    required this.themeColorPalette,
    required this.themeConfiguration,
    required this.themeApplicationStatus,
    required this.sourceElementId,
    required this.targetElementId,
    required this.mappingRule,
    required this.mappingStatus,
    required this.mappingValidation,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
