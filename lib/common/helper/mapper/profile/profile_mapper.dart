import 'package:fitora_mobile_app/feature/profile/data/models/profile_model.dart';
import 'package:fitora_mobile_app/feature/profile/domain/entities/profile_entity.dart';

class ProfileMapper {
  static ProfileEntity toEntity(ProfileModel profile) {
    return ProfileEntity();
  }
}