/// Data model tracking ISO 9001:2015 process execution audit configuration logs
class ViewportAuditLogRecord {
  final String configurationParameter;
  final String currentSetting;
  final String previousSetting;
  final String changeLog;
  final String configurationTimestamp;

  ViewportAuditLogRecord({
    required this.configurationParameter,
    required this.currentSetting,
    required this.previousSetting,
    required this.changeLog,
    required this.configurationTimestamp,
  });
}

/// Represents real-time device viewport aspect configuration metadata
class ViewportAspectMetadata {
  final double widthDp;
  final double heightDp;
  final double aspectRatio;
  final String aspectString;
  final bool isParsingValid;
  final bool isValidationFrozen;

  ViewportAspectMetadata({
    required this.widthDp,
    required this.heightDp,
    required this.aspectRatio,
    required this.aspectString,
    this.isParsingValid = true,
    this.isValidationFrozen = false,
  });
}
