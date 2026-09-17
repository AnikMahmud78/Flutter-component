// lib/models/promo_roi_model.dart
class PromoRoiModel {
  final double redemptionAccuracy;
  final double roiValue;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const PromoRoiModel({
    required this.redemptionAccuracy,
    required this.roiValue,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
