import 'package:fitora_mobile_app/core/utils/regex_validator.dart';

extension StringValidatorExtension on String {
  bool get isEmailValid => RegexValidator.email.hasMatch(this);
  bool get isPasswordValid => RegexValidator.password.hasMatch(this);
}
