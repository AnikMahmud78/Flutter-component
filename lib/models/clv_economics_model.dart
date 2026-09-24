import 'package:flutter/foundation.dart';

enum EconomicsStatus { high, medium, low }

@immutable
class ClvEconomicsModel {
  final String taskId;
  final double clvValue;
  final double cacValue;
  final double ratio;
  final double growthRatePercent;
  final EconomicsStatus status;
  final DateTime timestamp;
  final String userId;

  const ClvEconomicsModel({
    required this.taskId,
    required this.clvValue,
    required this.cacValue,
    required this.ratio,
    required this.growthRatePercent,
    required this.status,
    required this.timestamp,
    required this.userId,
  });
}
