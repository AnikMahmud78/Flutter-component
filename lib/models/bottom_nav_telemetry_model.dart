// Location: lib/models/bottom_nav_telemetry_model.dart
import 'package:flutter/foundation.dart';

/// Representation of business rule threshold definitions
@immutable
class BusinessRuleDefinitionItem {
  final String definitionName;
  final String definitionParameters;
  final String definitionType;
  final String validationStatus;
  final String definitionId;

  const BusinessRuleDefinitionItem({
    required this.definitionName,
    required this.definitionParameters,
    required this.definitionType,
    required this.validationStatus,
    required this.definitionId,
  });
}

/// Atomic Telemetry Record for Task 13811ANSA-001 Audits
@immutable
class BottomNavTelemetryRecord {
  final String definitionName;
  final String definitionParameters;
  final String definitionType;
  final String validationStatus;
  final String definitionId;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final double thresholdCoverage;

  const BottomNavTelemetryRecord({
    required this.definitionName,
    required this.definitionParameters,
    required this.definitionType,
    required this.validationStatus,
    required this.definitionId,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    this.thresholdCoverage = 1.0, // 100% Rules Formally Defined & Peer-Reviewed
  });
}
