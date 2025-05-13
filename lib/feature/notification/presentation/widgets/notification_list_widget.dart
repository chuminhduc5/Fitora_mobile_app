import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/feature/notification/presentation/blocs/notification_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotificationListWidget extends StatelessWidget {
  const NotificationListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBloc, NotificationState>(
      builder: (context, state) {
        if (state is FetchNotificationLoadingState) {
          return const AppLoadingWidget();
        } else if (state is FetchNotificationFailureState) {
          return AppErrorWidget(state.message);
        } else if (state is FetchNotificationSuccessState) {
          final friendRequests = state.friendRequests;
          final groupInvites = state.groupInvites;
          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {},
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  List<Widget> _buildNotificationSections(FetchNotificationSuccessState state) {
    final widgets = <Widget>[];

    if (state.friendRequests.isNotEmpty) {
      widgets.add(Text('Lời mời kết bạn', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
      //widgets.addAll(state.friendRequests.map((f) => ListTile(title: Text(f))));
      widgets.add(SizedBox(height: 20));
    }

    if (state.groupInvites.isNotEmpty) {
      widgets.add(Text('Lời mời tham gia nhóm', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)));
      //widgets.addAll(state.groupInvites.map((g) => ListTile(title: Text(g))));
    }

    if (widgets.isEmpty) {
      widgets.add(Center(child: Text('Không có thông báo nào.')));
    }

    return widgets;
  }
}
