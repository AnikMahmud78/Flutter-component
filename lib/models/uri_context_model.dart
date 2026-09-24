import 'package:flutter/foundation.dart';

enum UriRoutingStatus { complete, partial, notComplete }

@immutable
class UriContextModel {
  final String taskId;
  final String traceId;
  final String rawUri;
  final UriRoutingStatus status;
  final double completionRate;
  final DateTime timestamp;
  final String userId;

  const UriContextModel({
    required this.taskId,
    required this.traceId,
    required this.rawUri,
    required this.status,
    required this.completionRate,
    required this.timestamp,
    required this.userId,
  });
}
