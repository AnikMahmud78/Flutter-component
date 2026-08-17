/// Data model tracking mobile device hardware telemetry for Six Sigma compliance logs
class MobileDeviceTelemetryRecord {
  final String mobilePlatform;
  final String osVersion;
  final String deviceType;
  final String screenDimensions;
  final String mobileConfiguration;

  MobileDeviceTelemetryRecord({
    required this.mobilePlatform,
    required this.osVersion,
    required this.deviceType,
    required this.screenDimensions,
    required this.mobileConfiguration,
  });
}

/// Banned Term Transformer Item representing human-to-machine verb mappings
class CtaTermMappingItem {
  final String workflowId;
  final String bannedHumanPhrase;
  final String ecSystemVerb;
  final bool isCompliant;

  CtaTermMappingItem({
    required this.workflowId,
    required this.bannedHumanPhrase,
    required this.ecSystemVerb,
    this.isCompliant = true,
  });
}
