class SignInReqParams {
  final String email;
  final String password;

  const SignInReqParams({
    required this.email,
    required this.password,
  });

  @override
  String toString() {
    return 'SignInReqParams(email: $email, password: $password)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }
}
