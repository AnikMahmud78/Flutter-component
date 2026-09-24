import 'package:flutter/foundation.dart';

@immutable
class NpmpublisherModel {
  final String packageName;
  final String semverVersion;
  final double coveragePercentage;

  const NpmpublisherModel({
    required this.packageName,
    required this.semverVersion,
    required this.coveragePercentage,
  });

  String get completionStatus {
    if (coveragePercentage >= 100.0) return 'Complete';
    if (coveragePercentage >= 95.0) return 'Partial';
    return 'Not Complete';
  }
}
