import 'package:flutter/foundation.dart';

@immutable
class GcpInfraRepoModel {
  final String repoPath;
  final String commitHash;
  final double completionRate;

  const GcpInfraRepoModel({
    required this.repoPath,
    required this.commitHash,
    required this.completionRate,
  });

  String get completionStatus {
    if (completionRate >= 99.0) return 'Complete';
    if (completionRate >= 90.0) return 'Partial';
    return 'Not Complete';
  }
}
