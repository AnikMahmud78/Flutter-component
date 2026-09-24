import 'package:flutter/foundation.dart';

@immutable
class KeyringManagerModel {
  final String keyAlias;
  final bool isKeyBoundToHardware;
  final double completionRate;

  const KeyringManagerModel({
    required this.keyAlias,
    required this.isKeyBoundToHardware,
    required this.completionRate,
  });

  String get completionStatus {
    if (completionRate >= 99.0) return 'Complete';
    if (completionRate >= 90.0) return 'Partial';
    return 'Not Complete';
  }
}
