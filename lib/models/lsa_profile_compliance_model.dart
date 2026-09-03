import 'package:flutter/foundation.dart';

/// Representation of LSA Profile Compliance Status
@immutable
class LsaProfileComplianceRecord {
  final String mobilePlatform;
  final String osVersion;
  final String deviceType;
  final String screenDimensions;
  final String mobileConfiguration;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const LsaProfileComplianceRecord({
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
