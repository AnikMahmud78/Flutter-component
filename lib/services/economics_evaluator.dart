import '../models/clv_economics_model.dart';

class EconomicsEvaluator {
  static ClvEconomicsModel calculateRatio({
    required String taskId,
    required double clv,
    required double cac,
    required String userId,
  }) {
    final double ratio = cac > 0 ? clv / cac : 0.0;
    final bool pass = ratio >= 3.0;
    return ClvEconomicsModel(
      taskId: taskId,
      clvValue: clv,
      cacValue: cac,
      ratio: ratio,
      growthRatePercent: 30.0,
      status: pass ? EconomicsStatus.high : EconomicsStatus.low,
      timestamp: DateTime.now(),
      userId: userId,
    );
  }
}
