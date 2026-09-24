import 'package:flutter/foundation.dart';

@immutable
class SwipeProgressionModel {
  final bool isSingleActionValid;
  final double lockRatePercentage;

  const SwipeProgressionModel({
    required this.isSingleActionValid,
    required this.lockRatePercentage,
  });

  String get completionStatus => lockRatePercentage >= 99.0 ? 'Pass' : 'Fail';
}
