// lib/models/multi_cart_model.dart
class MultiCartModel {
  final double cartIntegrityRate;
  final int maxBookings;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const MultiCartModel({
    required this.cartIntegrityRate,
    required this.maxBookings,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
