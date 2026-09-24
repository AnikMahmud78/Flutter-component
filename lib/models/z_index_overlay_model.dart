import 'package:flutter/foundation.dart';

@immutable
class ZIndexOverlayModel {
  final bool isOverlayActive;
  final double complianceRate;

  const ZIndexOverlayModel({
    required this.isOverlayActive,
    required this.complianceRate,
  });

  String get completionStatus => complianceRate >= 95.0 ? 'Pass' : 'Fail';
}
