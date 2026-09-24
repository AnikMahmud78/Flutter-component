import '../models/calamity_gap_model.dart';

class CalamityChannelService {
  static CalamityGapModel fetchActiveGap({required String taskId, required String userId}) {
    return CalamityGapModel(
      taskId: taskId,
      gapId: 'GAP-CALAMITY-992',
      description: 'Logic flaw in cross-region payload fallback routing',
      status: EscalationStatus.complete,
      completionRate: 99.0,
      loggedAt: DateTime.now(),
      assignedLeaderId: userId,
    );
  }
}
