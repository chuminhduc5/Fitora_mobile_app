import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/auth_token_entity.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/user_entity.dart';

class AuthEntity extends Equatable{
  final UserEntity user;
  final AuthTokenEntity token;

  const AuthEntity ({required this.user, required this.token});

  @override
  List<Object?> get props => [user, token];
}