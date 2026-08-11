/// Data model holding state across deconstructed single-input screens
class AtomicStepState {
  String userId;
  double payloadAmount;
  bool isConfirmed;

  AtomicStepState({
    this.userId = '',
    this.payloadAmount = 0.0,
    this.isConfirmed = false,
  });

  bool get isStep1Valid => userId.trim().length >= 4;
  bool get isStep2Valid => payloadAmount > 0;
  bool get isStep3Valid => isConfirmed;

  bool get isCompleteWorkflowValid =>
      isStep1Valid && isStep2Valid && isStep3Valid;
}
