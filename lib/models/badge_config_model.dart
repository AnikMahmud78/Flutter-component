class BadgeConfigModel {
  final double badgeHeight;
  final double touchTargetSize;
  final String statusText;
  final String validationResult;

  BadgeConfigModel({
    required this.badgeHeight,
    required this.touchTargetSize,
    required this.statusText,
    required this.validationResult,
  });

  Map<String, dynamic> toJson() => {
        'badge_height': badgeHeight,
        'touch_target_size': touchTargetSize,
        'status_text': statusText,
        'validation_result': validationResult,
      };
}
