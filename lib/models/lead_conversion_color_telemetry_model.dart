import 'package:flutter/foundation.dart';

@immutable
class LeadConversionColorTelemetryRecord {
  final String colorCodeHex;
  final String colorName;
  final String colorScheme;
  final double contrastRatio;
  final String colorApplicationMap;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const LeadConversionColorTelemetryRecord({
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
