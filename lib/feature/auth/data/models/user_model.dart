import 'package:fitora_mobile_app/feature/auth/domain/entities/user_entity.dart';

import 'auth_token_model.dart';

class UserModel {
  final String id;
  final String userName; // Tương ứng với email
  final String fullName; // Tương ứng với username

  const UserModel({
    required this.id,
    required this.userName,
    required this.fullName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      userName: json['userName'] ?? '',
      fullName: json['fullName'] ?? '',
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      userName: userName,
      fullName: fullName,
    );
  }
}
