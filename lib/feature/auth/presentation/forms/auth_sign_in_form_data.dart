class AuthSignInFormData {
  final String email;
  final String password;

  const AuthSignInFormData({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }
}

