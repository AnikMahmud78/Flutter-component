import 'package:flutter/foundation.dart';

@immutable
class PriceSummaryModel {
  final double subtotal;
  final double serviceFee;
  final double tax;
  final double calculationAccuracy;

  const PriceSummaryModel({
    required this.subtotal,
    required this.serviceFee,
    required this.tax,
    required this.calculationAccuracy,
  });

  double get total => subtotal + serviceFee + tax;

  String get completionStatus => calculationAccuracy >= 0.99 ? 'Pass' : 'Fail';
}
