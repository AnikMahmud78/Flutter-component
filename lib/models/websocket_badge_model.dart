import 'package:flutter/foundation.dart';

@immutable
class WebSocketBadgeModel {
  final int unreadCount;
  final double syncSuccessRate;

  const WebSocketBadgeModel({
    required this.unreadCount,
    required this.syncSuccessRate,
  });

  String get completionStatus => syncSuccessRate >= 0.97 ? 'Pass' : 'Fail';
}
