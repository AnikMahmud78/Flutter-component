// lib/models/triangular_check_model.dart
class TriangularCheckModel {
  final double amountA;
  final double amountB;
  final double variance;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const TriangularCheckModel({
    required this.amountA,
    required this.amountB,
    required this.variance,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
