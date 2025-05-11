import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/friend/friend_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FriendInvitationScreen extends StatefulWidget {
  const FriendInvitationScreen({super.key});

  @override
  State<FriendInvitationScreen> createState() => _FriendInvitationScreenState();
}

class _FriendInvitationScreenState extends State<FriendInvitationScreen> {
  late FriendBloc _userBloc;

  @override
  void initState() {
    _userBloc = getIt<FriendBloc>()..add(FetchRecommendUserEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _userBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Gợi ý kết bạn"),
          leading: IconButton(
            onPressed: () {
              context.goNamed(AppRoute.notification.name);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(
              const Duration(seconds: 1),
            ).then(
                  (value) => context.read<FriendBloc>().add(
                FetchRecommendUserEvent(),
              ),
            );
          },
          child: BlocBuilder<FriendBloc, FriendState>(
            builder: (context, state) {
              return SizedBox();
              // if (state is FetchRecommendUserLoadingState) {
              //   return const AppLoadingWidget();
              // } else if (state is FetchRecommendUserFailureState) {
              //   return AppErrorWidget(state.message);
              // } else if (state is FetchRecommendUserSuccessState) {
              //   final users = state.users;
              //   return CustomScrollView(
              //     slivers: [
              //       SliverList(
              //         delegate: SliverChildBuilderDelegate(
              //               (context, index) {
              //             final user = users[index];
              //             return FriendInvitationCardWidget(user: user, onPressed: () {
              //               context.pushNamed(AppRoute.personal.name, extra: user.id);
              //             },);
              //           },
              //           childCount: users.length,
              //         ),
              //       ),
              //     ],
              //   );
              // }
              // return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}