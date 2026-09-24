import 'package:flutter/foundation.dart';

@immutable
class ZeroZoomModel {
  final bool isFitToViewport;
  final double completionRate;

  const ZeroZoomModel({
    required this.isFitToViewport,
    required this.completionRate,
  });

  String get completionStatus {
    if (completionRate >= 99.0) return 'Complete';
    if (completionRate >= 90.0) return 'Partial';
    return 'Not Complete';
  }
}
