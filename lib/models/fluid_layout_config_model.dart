/// Data model tracking atomic layout configuration telemetry for <FluidResolutionAdaptor>
class FluidLayoutConfigRecord {
  final String configurationKey;
  final String configurationValue;
  final String configurationType;
  final String validationStatus;
  final String configurationTimestamp;

  FluidLayoutConfigRecord({
    required this.configurationKey,
    required this.configurationValue,
    required this.configurationType,
    required this.validationStatus,
    required this.configurationTimestamp,
  });
}
