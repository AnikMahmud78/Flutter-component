import '../models/field_subtext_model.dart';

class FieldSubtextService {
  static FieldSubtextModel getSubtextConfig({required String taskId, required String userId}) {
    return FieldSubtextModel(
      taskId: taskId,
      fieldId: 'FIELD-TRACE-ID-90',
      actionableSubtext: 'Enter a valid 16-character trace identifier (e.g. TRACE-2026-X190).',
      status: SubtextState.complete,
      completionRate: 99.0,
      timestamp: DateTime.now(),
      userId: userId,
    );
  }
}
