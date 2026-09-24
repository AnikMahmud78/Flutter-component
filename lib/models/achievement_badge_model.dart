import 'package:flutter/foundation.dart';

enum BadgeTier { bronze, silver, gold, platinum }

@immutable
class AchievementBadgeModel {
  final String taskId;
  final String badgeTitle;
  final String description;
  final BadgeTier tier;
  final double completionRate;
  final DateTime unlockedAt;
  final String userId;

  const AchievementBadgeModel({
    required this.taskId,
    required this.badgeTitle,
    required this.description,
    required this.tier,
    required this.completionRate,
    required this.unlockedAt,
    required this.userId,
  });
}
