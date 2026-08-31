// Location: lib/models/screen_performance_tag_model.dart
import 'package:flutter/foundation.dart';

/// Performance tag extracted from rendered UI components
@immutable
class UiComponentPerformanceTag {
  final String componentName;
  final String componentType;
  final String componentProperties;
  final String stateDefinitions;
  final String componentHierarchy;
  final double renderLatencyMs;
  final bool isMd3Compliant;

  const UiComponentPerformanceTag({
    required this.componentName,
    required this.componentType,
    required this.componentProperties,
    required this.stateDefinitions,
    required this.componentHierarchy,
    required this.renderLatencyMs,
    this.isMd3Compliant = true,
  });
}

/// Atomic Telemetry Record for Task 6859AEETE-031-13 Audits
@immutable
class ScreenPerformanceTelemetryRecord {
  final String componentName;
  final String componentType;
  final String componentProperties;
  final String stateDefinitions;
  final String componentHierarchy;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final double uiAdherenceRate;

  const ScreenPerformanceTelemetryRecord({
    required this.componentName,
    required this.componentType,
    required this.componentProperties,
    required this.stateDefinitions,
    required this.componentHierarchy,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    this.uiAdherenceRate = 1.0, // 100% Adherence Rate
  });
}
