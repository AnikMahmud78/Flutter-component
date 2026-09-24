import 'package:flutter/foundation.dart';

@immutable
class BigQueryStreamModel {
  final String traceId;
  final int queuedEvents;
  final double streamLatencyMinutes;

  const BigQueryStreamModel({
    required this.traceId,
    required this.queuedEvents,
    required this.streamLatencyMinutes,
  });

  String get completionStatus {
    if (streamLatencyMinutes <= 5) return 'Good';
    if (streamLatencyMinutes <= 60) return 'Average';
    return 'Poor';
  }
}
