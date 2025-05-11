import 'package:fitora_mobile_app/feature/user/data/models/responses/group_model.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/group_entity.dart';

class GroupMapper {
  static GroupResponseEntity toEntity(GroupResponseModel model) {
    return GroupResponseEntity(
      group: model.group.toEntity(),
      groupMember: model.groupMember.toEntity(),
    );
  }
}
