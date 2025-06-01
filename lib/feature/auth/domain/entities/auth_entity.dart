import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable{
  final UserEntity user;
  final AuthTokenEntity token;

  const AuthEntity ({required this.user, required this.token});

  @override
  List<Object?> get props => [user, token];
}

class UserEntity extends Equatable {
  final String id;
  final String userName;
  final String fullName;

  const UserEntity({
    required this.id,
    required this.userName,
    required this.fullName,
  });

  @override
  List<Object?> get props => [id, userName, fullName];
}

class AuthTokenEntity extends Equatable {
  final String accessToken;
  final String refreshToken;

  const AuthTokenEntity({
    required this.accessToken,
    required this.refreshToken
  });

  @override
  List<Object?> get props => [accessToken, refreshToken];
}