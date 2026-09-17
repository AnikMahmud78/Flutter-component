// lib/models/clock_decorator_model.dart
class ClockDecoratorModel {
  final String fileName;
  final bool isSyntaxValid;
  final String completionStatus;
  final String actionEventTimestamp;
  final String userSessionId;

  const ClockDecoratorModel({
    required this.fileName,
    required this.isSyntaxValid,
    required this.completionStatus,
    required this.actionEventTimestamp,
    required this.userSessionId,
  });
}
