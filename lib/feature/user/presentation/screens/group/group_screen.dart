import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/group/group_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/screens/group/group_management_role_screen.dart';
import 'package:fitora_mobile_app/feature/user/presentation/screens/group/group_member_role_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupScreen extends StatefulWidget {
  final String groupId;
  const GroupScreen({super.key, required this.groupId});

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<GroupBloc>().add(FetchGroupByIdEvent(id: widget.groupId));
    return Scaffold(
      backgroundColor: AppColors.bgWhite,
      //appBar: AppBar(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(
              const Duration(seconds: 1),
            ).then(
                  (value) => context.read<GroupBloc>().add(
                FetchGroupByIdEvent(id: widget.groupId),
              ),
            );
          },
          child: BlocBuilder<GroupBloc, GroupState>(
            builder: (context, state) {
              if (state is FetchGroupByIdLoadingState) {
                return const AppLoadingWidget();
              } else if (state is FetchGroupByIdFailureState) {
                return AppErrorWidget(state.message);
              } else if (state is FetchGroupByIdSuccessState) {
                final groupInfo = state.data;
                final groupRole = groupInfo.groupMember.role;
                final memberImageUrl = groupInfo.groupMember.profilePictureUrl;
                logg.i("Group Role: $groupRole");
                logg.i("Member Image Url: $memberImageUrl");
                return groupRole == 1
                    ? GroupManagementRoleScreen(groupInfo: groupInfo)
                    : GroupMemberRoleScreen(groupInfo: groupInfo);

                // return groupRole == 1
                //     ? GroupMemberRoleScreen(groupInfo: groupInfo)
                //     : GroupManagementRoleScreen(groupInfo: groupInfo);
              }
              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}

