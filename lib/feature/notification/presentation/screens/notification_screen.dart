import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/feature/notification/presentation/blocs/notification_bloc.dart';
import 'package:fitora_mobile_app/feature/notification/presentation/widgets/received_friend_request_card_widget.dart';
import 'package:fitora_mobile_app/feature/notification/presentation/widgets/received_group_invite_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bgPink,
        title: const Text("Thông báo", style: TextStyle(color: AppColors.white)),
        // leading: IconButton(
        //   onPressed: () {
        //     context.goNamed(AppRoute.appView.name);
        //   },
        //   icon: const Icon(Icons.arrow_back),
        // ),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (context) =>
              getIt<NotificationBloc>()..add(FetchNotificationEvent()),
          child: RefreshIndicator(
            onRefresh: () async {
              Future.delayed(const Duration(seconds: 1));
              context.read<NotificationBloc>().add(FetchNotificationEvent());
            },
            child: BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                if (state is FetchNotificationLoadingState) {
                  return const AppLoadingWidget();
                } else if (state is FetchNotificationFailureState) {
                  return AppErrorWidget(state.message);
                } else if (state is FetchNotificationSuccessState) {
                  final friendRequests = state.friendRequests;
                  final groupInvites = state.groupInvites;
                  if (friendRequests.isEmpty && groupInvites.isEmpty) {
                    return const Center(child: Text('Bạn không có thông báo nào!'),);
                  }
                  return CustomScrollView(
                    slivers: [
                      if (friendRequests.isNotEmpty) ...[
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              "Lời mời kết bạn",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              return ReceivedFriendRequestCardWidget(
                                friend: friendRequests[index],
                              );
                            },
                            childCount: friendRequests.length,
                          ),
                        ),
                      ],
                      if (groupInvites.isNotEmpty) ...[
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              "Lời mời tham gia nhóm",
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              return ReceivedGroupInviteCardWidget(
                                groupInvite: groupInvites[index],
                              );
                            },
                            childCount: groupInvites.length,
                          ),
                        ),
                      ],
                    ],
                  );
                }
                return const SizedBox(child: Text('Bạn không có thông báo nào!'),);
              },
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
// import 'package:fitora_mobile_app/feature/notification/presentation/widgets/friend_notification_widget.dart';
// import 'package:fitora_mobile_app/feature/notification/presentation/widgets/recommend_friend_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
//
// class NotificationScreen extends StatelessWidget {
//   const NotificationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Thông báo"),
//         leading: IconButton(
//           onPressed: () {
//             context.goNamed(AppRoute.appView.name);
//           },
//           icon: const Icon(Icons.arrow_back),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             RecommendFriendWidget(
//               friend: "",
//               onPressed: () {
//                 context.goNamed(AppRoute.friendInvitation.name);
//               },
//             ),
//             FriendNotificationWidget(
//               friend: "Nguyễn Thế Huy Hoàng",
//               onPressed: () {
//                 context.goNamed(AppRoute.friendInvitation.name);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
