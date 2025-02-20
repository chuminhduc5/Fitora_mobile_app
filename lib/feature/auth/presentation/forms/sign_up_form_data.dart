import 'package:equatable/equatable.dart';

class SignUpFormData extends Equatable {
  final String email;
  final String username;
  final String password;
  final String confirmPassword;
  final bool isValid;

  const SignUpFormData({
    required this.email,
    required this.username,
    required this.password,
    required this.confirmPassword,
    required this.isValid,
  });

  @override
  List<Object?> get props =>
      [
        email,
        username,
        password,
        confirmPassword,
        isValid,
      ];

  SignUpFormData copyWith({
    String? email,
    String? username,
    String? password,
    String? confirmPassword,
    bool? isValid,
  }) {
    return SignUpFormData(email: email ?? this.email,
      username: username ?? this.username,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isValid: isValid ?? this.isValid,
    );
  }
}
