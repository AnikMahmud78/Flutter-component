import 'package:flutter/foundation.dart';

@immutable
class AtomicBytModel {
  final String bytName;
  final bool isAtomicCompliant;
  final double completionRate;

  const AtomicBytModel({
    required this.bytName,
    required this.isAtomicCompliant,
    required this.completionRate,
  });

  String get completionStatus {
    if (completionRate >= 99.0) return 'Complete';
    if (completionRate >= 90.0) return 'Partial';
    return 'Not Complete';
  }
}
