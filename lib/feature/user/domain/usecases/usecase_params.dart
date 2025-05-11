import 'users/update_profile_use_case.dart' as update_profile_params;
import 'groups/create_group_use_case.dart' as create_group_params;
import 'groups/update_group_use_case.dart' as update_group_params;
import 'groups/invite_new_members_use_case.dart' as invite_new_member_params;

typedef UpdateProfileParams = update_profile_params.Params;

typedef CreateGroupParams = create_group_params.Params;
typedef UpdateGroupParams = update_group_params.Params;
typedef InviteNewMembersParams = invite_new_member_params.Params;