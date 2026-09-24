import '../models/virtual_node_model.dart';

class NodeLifecycleManager {
  static VirtualNodeModel evaluateNodeUnmounting({
    required String taskId,
    required int totalElements,
    required int visibleElements,
    required String userId,
  }) {
    final int unmounted = totalElements - visibleElements;
    return VirtualNodeModel(
      taskId: taskId,
      activeNodesInMemory: visibleElements,
      unmountedNodesCount: unmounted,
      status: UnmountState.complete,
      completionRate: 99.0,
      timestamp: DateTime.now(),
      sessionUser: userId,
    );
  }
}
