// Location: lib/models/nullable_audit_telemetry_model.dart

/// Data record with multiple optional/nullable attributes
class NullableRecordModel {
  final String? recordId;
  final String? entityName;
  final String? categoryTag;
  final double? fundingAmountUsd;
  final double? targetGoalUsd;
  final DateTime? createdAt;

  NullableRecordModel({
    this.recordId,
    this.entityName,
    this.categoryTag,
    this.fundingAmountUsd,
    this.targetGoalUsd,
    this.createdAt,
  });

  bool get isEntirelyNull =>
      recordId == null &&
      entityName == null &&
      categoryTag == null &&
      fundingAmountUsd == null;
}

/// Atomic Telemetry Record for Task 3152FEBFL-021 Audits
class NullableAuditTelemetryRecord {
  final String mobilePlatform;
  final String osVersion;
  final String deviceType;
  final String screenDimensions;
  final String mobileConfiguration;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  NullableAuditTelemetryRecord({
    required this.mobilePlatform,
    required this.osVersion,
    required this.deviceType,
    required this.screenDimensions,
    required this.mobileConfiguration,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
