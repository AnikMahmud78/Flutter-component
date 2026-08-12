/// Data model representing a friction/hesitation telemetry event
class FrictionEventModel {
  final String eventId;
  final String frictionType; // RAGE_TAP, FIELD_HESITATION, LAYOUT_LOADED
  final String layoutType;
  final String layoutGridDimensions;
  final String spacingRules;
  final String alignmentSettings;
  final String layoutValidationStatus;
  final String timestamp;
  final String userId;

  FrictionEventModel({
    required this.eventId,
    required this.frictionType,
    this.layoutType = 'Single-Column Mobile Form',
    this.layoutGridDimensions = '360x800 Mobile Viewport',
    this.spacingRules = '16px Grid Margins',
    this.alignmentSettings = 'Top-to-Bottom Auto Layout',
    this.layoutValidationStatus = 'Pass',
    required this.timestamp,
    required this.userId,
  });
}