/// Represents a deconstructed atomic Critical Data Element ("Byte")
class CdeByteNode {
  final String byteId;
  final String byteName;
  final String parentCdeName;
  final String fieldLabel;
  final String hintText;
  final String inputType; // TEXT, DROPDOWN, NUMERIC
  final List<String>? options;
  String currentInputValue;

  CdeByteNode({
    required this.byteId,
    required this.byteName,
    required this.parentCdeName,
    required this.fieldLabel,
    required this.hintText,
    required this.inputType,
    this.options,
    this.currentInputValue = '',
  });

  bool get isPopulated => currentInputValue.trim().isNotEmpty;
}

/// Data model tracking atomic configuration change logs for Data Engineering audits
class CdeConfigurationTelemetry {
  final String configurationParameter;
  final String currentSetting;
  final String previousSetting;
  final String changeLog;
  final String configurationTimestamp;

  CdeConfigurationTelemetry({
    required this.configurationParameter,
    required this.currentSetting,
    required this.previousSetting,
    required this.changeLog,
    required this.configurationTimestamp,
  });
}
