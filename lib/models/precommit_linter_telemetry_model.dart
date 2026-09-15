import 'package:flutter/foundation.dart';

@immutable
class PrecommitLinterTelemetryRecord {
  final String repositoryUrl;
  final String repositoryBranch;
  final String accessRights;
  final String commitHistory;
  final String repositoryVersion;
  final String cloneStatus;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const PrecommitLinterTelemetryRecord({
    required this.repositoryUrl,
    required this.repositoryBranch,
    required this.accessRights,
    required this.commitHistory,
    required this.repositoryVersion,
    required this.cloneStatus,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
