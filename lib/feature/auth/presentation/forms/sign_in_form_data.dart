import 'package:equatable/equatable.dart';

class SignInFormData extends Equatable {
  final String email;
  final String password;
  final bool isValid;

  const SignInFormData({
    required this.email,
    required this.password,
    required this.isValid,
  });

  @override
  List<Object?> get props => [email, password, isValid];

  SignInFormData copyWith({
    String? email,
    String? password,
    bool? isValid,
  }) {
    return SignInFormData(
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
    );
  }
}