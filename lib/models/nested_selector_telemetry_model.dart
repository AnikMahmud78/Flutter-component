import 'package:flutter/foundation.dart';

@immutable
class NestedSelectorTelemetryRecord {
  final String sourceElementId;
  final String targetElementId;
  final String mappingRule;
  final String mappingStatus;
  final String mappingValidation;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const NestedSelectorTelemetryRecord({
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
