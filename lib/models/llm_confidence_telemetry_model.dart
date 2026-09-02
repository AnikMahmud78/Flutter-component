import 'package:flutter/foundation.dart';

/// Representation of LLM Confidence Score Color State Mapping
@immutable
class LlmConfidenceColorMapping {
  final String colorCodeHex;
  final String colorName;
  final String colorScheme;
  final String contrastRatio;
  final String colorApplicationMap;

  const LlmConfidenceColorMapping({
    required this.colorCodeHex,
    required this.colorName,
    required this.colorScheme,
    required this.contrastRatio,
    required this.colorApplicationMap,
  });
}

/// Atomic Telemetry Record for Task 7211ARCPE-005-14 Audits
@immutable
class LlmConfidenceTelemetryRecord {
  final String colorCodeHex;
  final String colorName;
  final String colorScheme;
  final String contrastRatio;
  final String colorApplicationMap;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const LlmConfidenceTelemetryRecord({
    required this.colorCodeHex,
    required this.colorName,
    required this.colorScheme,
    required this.contrastRatio,
    required this.colorApplicationMap,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
