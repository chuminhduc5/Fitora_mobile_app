import 'package:fitora_mobile_app/feature/auth/domain/entities/auth_entity.dart';
import 'package:hive/hive.dart';

part 'auth_model.g.dart';

@HiveType(typeId: 4)
class AuthModel extends HiveObject {
  @HiveField(0)
  final UserModel user;

  @HiveField(1)
  final AuthTokenModel token;

  AuthModel({
    required this.user,
    required this.token,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      user: UserModel.fromJson(json['user'] ?? {}),
      token: AuthTokenModel.fromJson(json['token'] ?? {}),
    );
  }
}

@HiveType(typeId: 5) // typeId bạn tự định nghĩa, đảm bảo không trùng
class UserModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userName;

  @HiveField(2)
  final String fullName;

  UserModel({
    required this.id,
    required this.userName,
    required this.fullName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? '',
        userName: json['userName'] ?? '',
        fullName: json['fullName'] ?? '',
      );

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      userName: userName,
      fullName: fullName,
    );
  }
}

@HiveType(typeId: 6)
class AuthTokenModel extends HiveObject {
  @HiveField(0)
  final String accessToken;

  @HiveField(1)
  final String refreshToken;

  AuthTokenModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }

  AuthTokenEntity toEntity() {
    return AuthTokenEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
