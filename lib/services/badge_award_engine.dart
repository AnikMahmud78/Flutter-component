import '../models/achievement_badge_model.dart';

class BadgeAwardEngine {
  static AchievementBadgeModel fetchUserBadge({required String taskId, required String userId}) {
    return AchievementBadgeModel(
      taskId: taskId,
      badgeTitle: 'Zero-Defect Deployer',
      description: 'Maintained 100% CI/CD validation compliance across 50 consecutive deployments.',
      tier: BadgeTier.platinum,
      completionRate: 99.0,
      unlockedAt: DateTime.now(),
      userId: userId,
    );
  }
}
