// lib/models/code_constraint_model.dart
class CodeConstraintModel {
  final String functionName;
  final int lineCount;
  final bool isCompliant;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const CodeConstraintModel({
    required this.functionName,
    required this.lineCount,
    required this.isCompliant,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
