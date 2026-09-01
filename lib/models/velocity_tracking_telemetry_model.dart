// Location: lib/models/velocity_tracking_telemetry_model.dart
import 'package:flutter/foundation.dart';

/// Atomic Telemetry Record for Task 3955ANSA-018 Audits
@immutable
class VelocityTrackingTelemetryRecord {
  final String stepExecutionId;
  final String executionStatus;
  final String executionTimestamp;
  final String stepOutcome;
  final String userId;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final double measuredFps;

  const VelocityTrackingTelemetryRecord({
    required this.stepExecutionId,
    required this.executionStatus,
    required this.executionTimestamp,
    required this.stepOutcome,
    required this.userId,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    this.measuredFps = 60.0, // Stable >=58fps Target
  });
}
