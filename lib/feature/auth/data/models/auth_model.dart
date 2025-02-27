import 'package:fitora_mobile_app/feature/auth/data/models/auth_token_model.dart';
import 'package:fitora_mobile_app/feature/auth/data/models/user_model.dart';

class AuthModel {
  final UserModel user;
  final AuthTokenModel token;

  const AuthModel({required this.user, required this.token});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    final responseDto = json['data']?['responseDto'];
    if (responseDto == null) {
      throw Exception("Invalid response format: responseDto is null");
    }
    return AuthModel(
      user: UserModel.fromJson(responseDto['user'] ?? {}),
      token: AuthTokenModel.fromJson(responseDto['token'] ?? {}),
    );
  }
}