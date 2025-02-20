import 'package:fitora_mobile_app/feature/profile/data/models/personal_model.dart';
import 'package:fitora_mobile_app/feature/profile/domain/entities/personal_entity.dart';

class PersonalMapper {
  static PersonalEntity toEntity(PersonalModel personal) {
    return PersonalEntity();
  }
}