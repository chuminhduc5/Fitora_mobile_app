import 'package:fitora_mobile_app/feature/auth/data/models/responses/auth_token_model.dart';
import 'package:fitora_mobile_app/feature/auth/data/models/responses/user_model.dart';

class AuthModel {
  final UserModel user;
  final AuthTokenModel token;

  const AuthModel({required this.user, required this.token});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      user: UserModel.fromJson(json['user'] ?? {}),
      token: AuthTokenModel.fromJson(json['token'] ?? {}),
    );
  }
}