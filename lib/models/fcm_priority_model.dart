import 'package:flutter/foundation.dart';

@immutable
class FcmPriorityModel {
  final String channelId;
  final bool isHighPriority;
  final int mttdMinutes;

  const FcmPriorityModel({
    required this.channelId,
    required this.isHighPriority,
    required this.mttdMinutes,
  });

  String get completionStatus {
    if (mttdMinutes <= 2) return 'Good';
    if (mttdMinutes <= 15) return 'Average';
    return 'Poor';
  }
}
