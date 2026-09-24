import '../models/fluid_scaling_model.dart';

class FluidTextUtility {
  static double calculateFluidSize(double viewportWidth, double minSize, double maxSize) {
    final double rawSize = minSize + (viewportWidth * 0.015);
    return rawSize.clamp(minSize, maxSize);
  }

  static FluidScalingModel evaluateFluidState({
    required String taskId,
    required double viewportWidth,
    required String userId,
  }) {
    final double size = calculateFluidSize(viewportWidth, 14.0, 24.0);
    return FluidScalingModel(
      taskId: taskId,
      viewportWidth: viewportWidth,
      computedFontSize: size,
      status: ScalingStatus.complete,
      completionRate: 99.0,
      timestamp: DateTime.now(),
      userId: userId,
    );
  }
}
