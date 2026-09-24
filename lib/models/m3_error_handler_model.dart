import 'package:flutter/foundation.dart';

@immutable
class M3ErrorHandlerModel {
  final String? errorMessage;
  final double completionRate;

  const M3ErrorHandlerModel({
    this.errorMessage,
    required this.completionRate,
  });

  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;

  String get completionStatus {
    if (completionRate >= 99.0) return 'Complete';
    if (completionRate >= 90.0) return 'Partial';
    return 'Not Complete';
  }
}
