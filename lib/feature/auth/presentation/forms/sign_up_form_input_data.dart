import 'package:equatable/equatable.dart';

class SignUpFormInputData extends Equatable {
  final String inputEmail;
  final String inputUsername;
  final String inputPassword;
  final String inputConfirmPassword;
  final bool inputValid;

  const SignUpFormInputData({
    required this.inputEmail,
    required this.inputUsername,
    required this.inputPassword,
    required this.inputConfirmPassword,
    required this.inputValid,
  });

  @override
  List<Object?> get props => [
        inputEmail,
        inputUsername,
        inputPassword,
        inputConfirmPassword,
        inputValid,
      ];

  SignUpFormInputData copyWith({
    String? inputEmail,
    String? inputUsername,
    String? inputPassword,
    String? inputConfirmPassword,
    bool? inputValid,
  }) {
    return SignUpFormInputData(
      inputEmail: inputEmail ?? this.inputEmail,
      inputUsername: inputUsername ?? this.inputUsername,
      inputPassword: inputPassword ?? this.inputPassword,
      inputConfirmPassword: inputConfirmPassword ?? this.inputConfirmPassword,
      inputValid: inputValid ?? this.inputValid,
    );
  }
}
