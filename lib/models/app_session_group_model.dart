/// Data model holding App Session Grouping telemetry and mobile configuration
class AppSessionGroupModel {
  final String sessionGroupingId;
  final String mobilePlatform;
  final String osVersion;
  final String deviceType;
  final String screenDimensions;
  final String mobileConfiguration;
  final String timestamp;
  final bool isSdkInitialized;

  AppSessionGroupModel({
    required this.sessionGroupingId,
    required this.mobilePlatform,
    required this.osVersion,
    required this.deviceType,
    required this.screenDimensions,
    required this.mobileConfiguration,
    required this.timestamp,
    required this.isSdkInitialized,
  });
}
