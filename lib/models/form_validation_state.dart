class FormValidationState {
  final bool isFullNameValid;
  final bool isEmailValid;
  final bool isEmployeeIdValid;

  const FormValidationState({
    required this.isFullNameValid,
    required this.isEmailValid,
    required this.isEmployeeIdValid,
  });

  bool get isAllValid => isFullNameValid && isEmailValid && isEmployeeIdValid;

  double get completionRate {
    int validCount = (isFullNameValid ? 1 : 0) +
        (isEmailValid ? 1 : 0) +
        (isEmployeeIdValid ? 1 : 0);
    return validCount / 3.0;
  }
}
