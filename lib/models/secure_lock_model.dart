import 'package:flutter/foundation.dart';

@immutable
class SecureLockModel {
  final bool isEncrypted;
  final double recognitionAccuracy;

  const SecureLockModel({
    required this.isEncrypted,
    required this.recognitionAccuracy,
  });

  String get completionStatus {
    if (recognitionAccuracy >= 0.95) return 'Good';
    if (recognitionAccuracy >= 0.80) return 'Average';
    return 'Poor';
  }
}
