// lib/models/haptic_feedback_model.dart
// Task GEN-00326: Map haptic feedback patterns for all primary mobile interaction events.

class HapticFeedbackModel {
  final String interactionEvent;
  final String hapticPattern;
  final String status;
  final String timestamp;

  const HapticFeedbackModel({
    required this.interactionEvent,
    required this.hapticPattern,
    required this.status,
    required this.timestamp,
  });
}
