import '../models/ui_acknowledgement_model.dart';

class AckVerificationService {
  static UiAcknowledgementModel generateAckRecord({
    required String taskId,
    required bool confirmed,
    required String userId,
  }) {
    return UiAcknowledgementModel(
      taskId: taskId,
      userConfirmed: confirmed,
      feedbackDisplayed: confirmed,
      auditVerificationRate: 100.0,
      status: confirmed ? VerificationStatus.complete : VerificationStatus.notComplete,
      acknowledgedAt: DateTime.now(),
      userId: userId,
    );
  }
}
