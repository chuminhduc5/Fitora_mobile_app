class SignUpRequest {
  final String email;
  final String password;
  final String fullName;

  const SignUpRequest({
    required this.email,
    required this.password,
    required this.fullName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'fullName': fullName,
    };
  }
}
