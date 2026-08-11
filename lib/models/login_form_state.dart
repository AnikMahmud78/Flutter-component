/// Data model tracking mandatory authentication inputs
class LoginFormState {
  String email;
  String password;

  LoginFormState({this.email = '', this.password = ''});

  bool get isEmailValid => email.contains('@') && email.contains('.');
  bool get isPasswordValid => password.length >= 6;

  /// Mathematical Masking Condition: True only when all mandatory inputs pass
  bool get isFormValid => isEmailValid && isPasswordValid;
}
