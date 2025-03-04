import 'package:equatable/equatable.dart';

class SignInFormInputData extends Equatable {
  final String inputEmail;
  final String inputPassword;
  final bool inputIsValid;

  const SignInFormInputData({
    required this.inputEmail,
    required this.inputPassword,
    required this.inputIsValid,
  });

  @override
  List<Object?> get props => [inputEmail, inputPassword, inputIsValid];

  SignInFormInputData copyWith({
    String? inputEmail,
    String? inputPassword,
    bool? inputIsValid,
  }) {
    return SignInFormInputData(
      inputEmail: inputEmail ?? this.inputEmail,
      inputPassword: inputPassword ?? this.inputPassword,
      inputIsValid: inputIsValid ?? this.inputIsValid,
    );
  }
}
