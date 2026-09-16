class HesitationTelemetryModel {
  final String frontendTechnology;
  final String frameworkVersion;
  final String buildConfiguration;
  final String performanceMetrics;
  final String buildOutputPath;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const HesitationTelemetryModel({
    required this.frontendTechnology,
    required this.frameworkVersion,
    required this.buildConfiguration,
    required this.performanceMetrics,
    required this.buildOutputPath,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
