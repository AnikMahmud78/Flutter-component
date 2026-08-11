import 'package:flutter/material.dart';

/// Represents the health state of a monitored IT asset node
class AssetHealthNode {
  final String nodeId;
  final String nodeName;
  final double varianceScore;
  final bool isHealthy;

  AssetHealthNode({
    required this.nodeId,
    required this.nodeName,
    required this.varianceScore,
    required this.isHealthy,
  });
}

/// Represents a chronological anomaly telemetry log event
class TelemetryLogEvent {
  final String logId;
  final String timestamp;
  final String message;
  final String severity; // INFO, WARN, ANOMALY

  TelemetryLogEvent({
    required this.logId,
    required this.timestamp,
    required this.message,
    required this.severity,
  });

  Color getSeverityColor(ColorScheme colorScheme) {
    switch (severity) {
      case 'ANOMALY':
        return colorScheme.error;
      case 'WARN':
        return Colors.orange.shade800;
      default:
        return colorScheme.primary;
    }
  }
}
