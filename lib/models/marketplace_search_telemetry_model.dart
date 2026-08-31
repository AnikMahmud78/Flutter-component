import 'package:flutter/foundation.dart';

/// Atomic Telemetry Record for Task 14218ANSA-009 Audits
@immutable
class MarketplaceSearchTelemetryRecord {
  final String mobilePlatform;
  final String osVersion;
  final String deviceType;
  final String screenDimensions;
  final String mobileConfiguration;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const MarketplaceSearchTelemetryRecord({
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
