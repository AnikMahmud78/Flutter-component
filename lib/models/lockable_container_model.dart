// lib/models/lockable_container_model.dart
// Task GEN-00079: Build LockableFormContainer Component
class LockableContainerModel {
  final String componentName;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;
  final int rtoRecoverySeconds;

  const LockableContainerModel({
    required this.componentName,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
    required this.rtoRecoverySeconds,
  });
}
