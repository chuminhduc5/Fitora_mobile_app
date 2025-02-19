import 'package:equatable/equatable.dart';

class SignInFormInputData extends Equatable {
  final String inputEmail;
  final String inputPassword;
  final bool inputValid;

  const SignInFormInputData({
    required this.inputEmail,
    required this.inputPassword,
    required this.inputValid,
  });

  @override
  List<Object?> get props => [inputEmail, inputPassword, inputValid];

  SignInFormInputData copyWith({
    String? inputEmail,
    String? inputPassword,
    bool? inputValid,
  }) {
    return SignInFormInputData(
      inputEmail: inputEmail ?? this.inputEmail,
      inputPassword: inputPassword ?? this.inputPassword,
      inputValid: inputValid ?? this.inputValid,
    );
  }
}
