import 'package:flutter/foundation.dart';

@immutable
class GapContainerModel {
  final double gapDp;
  final double compliancePercentage;

  const GapContainerModel({
    required this.gapDp,
    required this.compliancePercentage,
  });

  String get completionStatus => compliancePercentage >= 98.0 ? 'Pass' : 'Fail';
}
