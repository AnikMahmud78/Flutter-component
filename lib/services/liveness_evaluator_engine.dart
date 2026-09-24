import '../models/liveness_health_model.dart';

class LivenessEvaluatorEngine {
  static LivenessHealthModel evaluateResponse({
    required String taskId,
    required int statusCode,
    required double latencyMs,
    required String userId,
  }) {
    ResponseHealthState state;
    if (statusCode == 200 && latencyMs < 100.0) {
      state = ResponseHealthState.healthy;
    } else if (statusCode == 200 && latencyMs >= 100.0) {
      state = ResponseHealthState.degraded;
    } else {
      state = ResponseHealthState.failed;
    }

    return LivenessHealthModel(
      taskId: taskId,
      httpStatusCode: statusCode,
      latencyMs: latencyMs,
      healthState: state,
      stepCompletionRate: 99.0,
      evaluatedAt: DateTime.now(),
      userId: userId,
    );
  }
}
