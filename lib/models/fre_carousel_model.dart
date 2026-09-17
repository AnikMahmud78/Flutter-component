// lib/models/fre_carousel_model.dart
class FreCarouselModel {
  final double freCompletionRate;
  final String componentName;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const FreCarouselModel({
    required this.freCompletionRate,
    required this.componentName,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
