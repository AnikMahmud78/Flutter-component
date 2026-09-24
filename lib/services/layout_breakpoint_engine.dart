import '../models/adaptive_layout_model.dart';

class LayoutBreakpointEngine {
  static AdaptiveLayoutModel evaluateWidth(double width, String taskId, String userId) {
    ActiveLayoutMode mode;
    if (width < 600) {
      mode = ActiveLayoutMode.compact;
    } else if (width < 840) {
      mode = ActiveLayoutMode.medium;
    } else {
      mode = ActiveLayoutMode.expanded;
    }

    return AdaptiveLayoutModel(
      taskId: taskId,
      currentMode: mode,
      status: LayoutStepStatus.complete,
      completionRate: 99.0,
      timestamp: DateTime.now(),
      userId: userId,
    );
  }
}
