import 'package:flutter/foundation.dart';

@immutable
class QRPassModel {
  final String passId;
  final String holderName;
  final String payload;
  final double scanSuccessRate;

  const QRPassModel({
    required this.passId,
    required this.holderName,
    required this.payload,
    required this.scanSuccessRate,
  });

  String get completionStatus => scanSuccessRate >= 0.97 ? 'Pass' : 'Fail';
}
