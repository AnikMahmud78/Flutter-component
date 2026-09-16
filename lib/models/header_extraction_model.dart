// lib/models/header_extraction_model.dart
class HeaderExtractionModel {
  final String traceId;
  final double extractionLatencyMs;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const HeaderExtractionModel({
    required this.traceId,
    required this.extractionLatencyMs,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
