import 'package:fitora_mobile_app/feature/user/data/models/responses/managed_group_model.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/managed_group_entity.dart';

class ManagedGroupMapper {
  static ManagedGroupEntity toEntity(ManagedGroupModel model) {
    return ManagedGroupEntity(
      id: model.id,
      name: model.name,
      description: model.description,
      privacy: model.privacy,
      requirePostApproval: model.requirePostApproval,
      coverImageUrl: model.coverImageUrl,
      avatarUrl: model.avatarUrl,
      status: model.status,
      memberCount: model.memberCount,
    );
  }
}
