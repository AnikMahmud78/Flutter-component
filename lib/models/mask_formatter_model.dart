// lib/models/mask_formatter_model.dart
class MaskFormatterModel {
  final String fieldKey;
  final String formatterPattern;
  final String placementLocation;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const MaskFormatterModel({
    required this.fieldKey,
    required this.formatterPattern,
    required this.placementLocation,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
