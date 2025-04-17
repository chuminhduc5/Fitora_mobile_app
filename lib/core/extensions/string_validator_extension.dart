import 'package:fitora_mobile_app/core/utils/regex_validator.dart';

extension StringValidatorExtension on String {
  bool get isEmailValid => RegexValidator.email.hasMatch(this);
  bool get isPasswordValid => RegexValidator.password.hasMatch(this);
  bool get hasMinLength => length >= 6;
  bool get hasNumber => contains(RegExp(r'\d'));
  bool get hasUpperAndLowerCase => contains(RegExp(r'[A-Z]')) && contains(RegExp(r'[a-z]'));
  bool get hasSpecialChar => contains(RegExp(r'[!@#$%^&*(),.?":{}|<>_\[\]\\\/\-+=~`]'));
}
