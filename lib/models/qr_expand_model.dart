import 'package:flutter/foundation.dart';

@immutable
class QRExpandModel {
  final String passId;
  final double scanSuccessRate;

  const QRExpandModel({
    required this.passId,
    required this.scanSuccessRate,
  });

  String get completionStatus => scanSuccessRate >= 0.97 ? 'Pass' : 'Fail';
}
