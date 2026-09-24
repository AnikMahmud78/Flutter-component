import 'package:flutter/foundation.dart';

@immutable
class ViewportBoundsModel {
  final double windowWidthDp;
  final double windowHeightDp;
  final double devicePixelRatio;
  final double compliancePercentage;

  const ViewportBoundsModel({
    required this.windowWidthDp,
    required this.windowHeightDp,
    required this.devicePixelRatio,
    required this.compliancePercentage,
  });

  String get windowSizeClass {
    if (windowWidthDp < 600) return 'Compact';
    if (windowWidthDp < 840) return 'Medium';
    return 'Expanded';
  }

  String get completionStatus => compliancePercentage >= 98.0 ? 'Pass' : 'Fail';
}
