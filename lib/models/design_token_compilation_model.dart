// lib/models/design_token_compilation_model.dart
class DesignTokenCompilationModel {
  final double successRate;
  final bool isCompiled;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const DesignTokenCompilationModel({
    required this.successRate,
    required this.isCompiled,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
