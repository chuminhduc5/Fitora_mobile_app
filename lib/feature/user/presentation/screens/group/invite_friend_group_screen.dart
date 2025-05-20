import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/friend/friend_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/group/group_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/users/users_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/group/invite_friend_group_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InviteFriendGroupScreen extends StatefulWidget {
  final String groupId;

  const InviteFriendGroupScreen({super.key, required this.groupId});

  @override
  State<InviteFriendGroupScreen> createState() =>
      _InviteFriendGroupScreenState();
}

class _InviteFriendGroupScreenState extends State<InviteFriendGroupScreen> {
  //bool _isInvite = false;
  Set<String> invitedUserIds = {};
  void _inviteFriendGroup(String userId) {
    primaryFocus?.unfocus();
    context.read<GroupBloc>().add(
          InviteNewMembersEvent(
            groupId: widget.groupId,
            receiverUserIds: [userId],
          ),
        );
    logg.i("Id Người dùng: $userId");
    setState(() {
      invitedUserIds.add(userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mời bạn bè'),
        leading: const CloseButton(),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) => getIt<UsersBloc>()..add(FetchUsersEvent()),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: BlocBuilder<UsersBloc, UsersState>(
                  builder: (context, state) {
                    if (state is FetchUsersLoadingState) {
                      return const AppLoadingWidget();
                    } else if (state is FetchUsersFailureState) {
                      return AppErrorWidget(state.message);
                    } else if (state is FetchUsersSuccessState) {
                      final users = state.data;
                      return SizedBox(
                        height: 500,
                        child: ListView.builder(
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            return InviteFriendGroupCardWidget(
                              user: user,
                              onPressed: _inviteFriendGroup,
                              isActionInvite: invitedUserIds.contains(user.id),
                            );
                          },
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
