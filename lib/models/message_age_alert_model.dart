import 'package:flutter/foundation.dart';

@immutable
class MessageAgeAlertModel {
  final String queueTopic;
  final int maxUnacknowledgedAgeSeconds;
  final DateTime lastChecked;

  const MessageAgeAlertModel({
    required this.queueTopic,
    required this.maxUnacknowledgedAgeSeconds,
    required this.lastChecked,
  });

  String get completionStatus {
    if (maxUnacknowledgedAgeSeconds <= 10) return 'Good';
    if (maxUnacknowledgedAgeSeconds <= 60) return 'Fair';
    return 'Poor';
  }
}
