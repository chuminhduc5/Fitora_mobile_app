import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/feature/notification/presentation/widgets/friend_notification_widget.dart';
import 'package:fitora_mobile_app/feature/notification/presentation/widgets/recommend_friend_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thông báo"),
        leading: IconButton(
          onPressed: () {
            context.goNamed(AppRoute.appView.name);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RecommendFriendWidget(
              friend: "",
              onPressed: () {
                context.goNamed(AppRoute.friendInvitation.name);
              },
            ),
            FriendNotificationWidget(
              friend: "Nguyễn Thế Huy Hoàng",
              onPressed: () {
                context.goNamed(AppRoute.friendInvitation.name);
              },
            ),
          ],
        ),
      ),
    );
  }
}
