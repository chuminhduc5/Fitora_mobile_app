import 'dart:io';
import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/group/group_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupListWidget extends StatelessWidget {
  const GroupListWidget({super.key});

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
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final group = data[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                  FileImage(File(group.avatarUrl)),
                ),
                title: Text(group.name),
                subtitle: Row(
                  children: [
                    Text(
                        '${group.memberCount.toString()} thành viên'),
                    const SizedBox(width: 6),
                    const Icon(Icons.circle,
                        color: Colors.blue, size: 10),
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
