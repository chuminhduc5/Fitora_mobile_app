import 'dart:io';
import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/avatar/app_avatar_widget.dart';
import 'package:fitora_mobile_app/core/config/assets/app_svg.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/group/group_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/widgets/group/group_delete_confirm_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ManagedGroupListWidget extends StatelessWidget {
  const ManagedGroupListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupBloc, GroupState>(
      builder: (context, state) {
        if (state is FetchManagedGroupLoadingState) {
          return const AppLoadingWidget();
        } else if (state is FetchManagedGroupFailureState) {
          return AppErrorWidget(state.message);
        } else if (state is FetchManagedGroupSuccessState) {
          final data = state.data;
          if (data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppSvg.noData),
                  const SizedBox(height: 12),
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
                  logg.i("Go to GroupScreen ID:${group.id}");
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
                trailing: SizedBox(
                  height: 24,
                  width: 24,
                  child: PopupMenuButton<String>(
                    padding: EdgeInsets.zero,
                    color: AppColors.bgWhite,
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) {
                      if (value == 'edit') {
                        context.pushNamed(
                          AppRoute.updateGroup.name,
                          extra: group,
                        );
                      } else if (value == 'delete') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return GroupDeleteConfirmDialogWidget(groupId: group.id);
                          },
                        );
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Chỉnh sửa nhóm'),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Xóa nhóm'),
                      ),
                    ],
                  ),
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
