import 'package:fitora_mobile_app/feature/auth/domain/entities/auth_token_entity.dart';

class AuthTokenModel {
  final String accessToken;
  final String refreshToken;

  AuthTokenModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }

  AuthTokenEntity toEntity() {
    return AuthTokenEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
