import '../models/mathematical_validation_model.dart';

class MathCheckEngine {
  static MathematicalValidationModel executeCheck({
    required String taskId,
    required String traceId,
    required double valueA,
    required double valueB,
    required String userId,
  }) {
    final double delta = (valueA - valueB).abs();
    final bool isBalanced = delta < 1e-6;
    final ValidationStatus status = isBalanced ? ValidationStatus.complete : ValidationStatus.notComplete;
    final double accuracy = isBalanced ? 100.0 : ((1.0 - (delta / (valueA == 0 ? 1.0 : valueA.abs()))) * 100).clamp(0.0, 100.0);

    return MathematicalValidationModel(
      taskId: taskId,
      traceId: traceId,
      valueA: valueA,
      valueB: valueB,
      delta: delta,
      status: status,
      validationAccuracy: accuracy,
      timestamp: DateTime.now(),
      userId: userId,
    );
  }
}
