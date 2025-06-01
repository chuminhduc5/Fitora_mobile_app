import 'dart:io';

import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/avatar/app_avatar_widget.dart';
import 'package:fitora_mobile_app/core/config/assets/app_svg.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/group/group_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class JoinedGroupListWidget extends StatelessWidget {
  const JoinedGroupListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupBloc, GroupState>(
      builder: (context, state) {
        if (state is FetchJoinedGroupLoadingState) {
          return const AppLoadingWidget();
        } else if (state is FetchJoinedGroupFailureState) {
          return AppErrorWidget(state.message);
        } else if (state is FetchJoinedGroupSuccessState) {
          final data = state.data;
          if (data.isEmpty) {
            Center(
              child: Column(
                children: [
                  SvgPicture.asset(AppSvg.noData),
                  const Text("No Data"),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final group = data[index];
              return ListTile(
                onTap: () {
                  logg.i(AppRoute.group.name);
                  logg.i(
                      "Go to GroupScreen ID:${group.id}");
                  context.pushNamed(
                    AppRoute.group.name,
                    extra: group.id,
                  );
                },
                leading: AppAvatarWidget(imagePath: group.avatarUrl, size: 40),
                title: Text(group.name),
                subtitle: Row(
                  children: [
                    Text(
                      '${group.memberCount.toString()} thành viên',
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.circle,
                      color: Colors.blue,
                      size: 10,
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
