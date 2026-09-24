import '../models/local_execution_model.dart';

class LocalStateEvaluator {
  static LocalExecutionModel runLocalLogic({required String taskId, required String userId}) {
    final Stopwatch sw = Stopwatch()..start();
    // Run client-side calculation in memory
    int acc = 0;
    for (int i = 0; i < 1000; i++) {
      acc += i;
    }
    sw.stop();

    return LocalExecutionModel(
      taskId: taskId,
      executedLocally: acc > 0,
      executionTimeMs: sw.elapsedMicroseconds / 1000.0,
      status: ExecutionState.complete,
      completionRate: 99.0,
      timestamp: DateTime.now(),
      userId: userId,
    );
  }
}
