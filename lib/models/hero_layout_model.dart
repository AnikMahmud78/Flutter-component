// lib/models/hero_layout_model.dart
class HeroLayoutModel {
  final double reviewAuthenticityRate;
  final bool hasHeroImage;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const HeroLayoutModel({
    required this.reviewAuthenticityRate,
    required this.hasHeroImage,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
