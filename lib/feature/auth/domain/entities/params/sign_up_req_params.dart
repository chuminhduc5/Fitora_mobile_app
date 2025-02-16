class SignUpReqParams {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;

  const SignUpReqParams({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
  }
}
