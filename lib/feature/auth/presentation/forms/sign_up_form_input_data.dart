import 'package:equatable/equatable.dart';

class SignUpFormInputData extends Equatable {
  final String inputEmail;
  final String inputUsername;
  final String inputPassword;
  final String inputConfirmPassword;
  final bool inputIsValid;

  const SignUpFormInputData({
    required this.inputEmail,
    required this.inputUsername,
    required this.inputPassword,
    required this.inputConfirmPassword,
    required this.inputIsValid,
  });

  @override
  List<Object?> get props => [
        inputEmail,
        inputUsername,
        inputPassword,
        inputConfirmPassword,
        inputIsValid,
      ];

  SignUpFormInputData copyWith({
    String? inputEmail,
    String? inputUsername,
    String? inputPassword,
    String? inputConfirmPassword,
    bool? inputIsValid,
  }) {
    return SignUpFormInputData(
      inputEmail: inputEmail ?? this.inputEmail,
      inputUsername: inputUsername ?? this.inputUsername,
      inputPassword: inputPassword ?? this.inputPassword,
      inputConfirmPassword: inputConfirmPassword ?? this.inputConfirmPassword,
      inputIsValid: inputIsValid ?? this.inputIsValid,
    );
  }
}
