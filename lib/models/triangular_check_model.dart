import 'package:flutter/foundation.dart';

@immutable
class TriangularCheckModel {
  final double sideA;
  final double sideB;
  final double totalC;
  final double accuracyScore;

  const TriangularCheckModel({
    required this.sideA,
    required this.sideB,
    required this.totalC,
    required this.accuracyScore,
  });

  bool get isBalanced => (sideA + sideB - totalC).abs() < 0.001;

  String get completionStatus {
    if (isBalanced && accuracyScore >= 99.99) return 'Complete';
    if (accuracyScore >= 99.5) return 'Partial';
    return 'Not Complete';
  }
}
