import 'package:equatable/equatable.dart';

class LoginFormData extends Equatable {
  final String email;
  final String password;
  final bool isValid;

  const LoginFormData({
    required this.email,
    required this.password,
    required this.isValid,
  });

  @override
  List<Object?> get props => [email, password, isValid];

  LoginFormData copyWith({
    String? email,
    String? password,
    bool? isValid,
  }) {
    return LoginFormData(
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
    );
  }
}