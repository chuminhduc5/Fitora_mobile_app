import 'package:fitora_mobile_app/feature/auth/data/models/responses/auth_model.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/auth_entity.dart';

class AuthMapper {
  static AuthEntity toEntity(AuthModel auth) {
    return AuthEntity(
      user: auth.user.toEntity(),
      token: auth.token.toEntity(),
    );
  }
}
