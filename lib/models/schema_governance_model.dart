// Location: lib/models/schema_governance_model.dart
import 'package:flutter/foundation.dart';

/// Representation of a collated output data schema within dependency chains
@immutable
class OutputDataSchemaEntry {
  final String schemaId;
  final String targetDependencyChain;
  final String criticalDataElements;
  final bool isSchemaLocked;
  final bool isReferentialIntegrityEnforced;

  const OutputDataSchemaEntry({
    required this.schemaId,
    required this.targetDependencyChain,
    required this.criticalDataElements,
    this.isSchemaLocked = true,
    this.isReferentialIntegrityEnforced = true,
  });
}

/// Atomic Telemetry Record for Task 3273AEETE-032-A01 Audits
@immutable
class SchemaGovernanceTelemetryRecord {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final double schemaConformityRate;

  const SchemaGovernanceTelemetryRecord({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    this.schemaConformityRate = 1.0, // 100% Governance Conformity
  });
}
