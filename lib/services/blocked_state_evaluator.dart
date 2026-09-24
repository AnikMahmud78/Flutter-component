import '../models/blocked_state_model.dart';

class BlockedStateEvaluator {
  static BlockedStateModel generateState({required String taskId, required String userId}) {
    return BlockedStateModel(
      taskId: taskId,
      blockReason: 'Missing mandatory OAuth2 scope: write:production_deployments',
      status: BlockedStatus.complete,
      completionRate: 99.0,
      timestamp: DateTime.now(),
      userId: userId,
    );
  }
}
