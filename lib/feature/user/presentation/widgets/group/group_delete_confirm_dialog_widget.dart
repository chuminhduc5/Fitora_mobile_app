import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/button/app_button_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/group/group_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GroupDeleteConfirmDialogWidget extends StatefulWidget {
  final String groupId;
  const GroupDeleteConfirmDialogWidget({super.key, required this.groupId});

  @override
  State<GroupDeleteConfirmDialogWidget> createState() =>
      _GroupDeleteConfirmDialogWidgetState();
}

class _GroupDeleteConfirmDialogWidgetState
    extends State<GroupDeleteConfirmDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setStateDialog) {
        return AlertDialog(
          backgroundColor: AppColors.bgWhite,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: const Text(
            'Bạn có chắc chắn muốn xóa nhóm?',
            style: TextStyle(fontSize: 22),
          ),
          actions: <Widget>[
            BlocConsumer<GroupBloc, GroupState>(
              listener: (context, state) {
                if (state is DeleteGroupFailureState) {
                  AppDisplayMessage.error(context, state.message);
                } else if (state is DeleteGroupSuccessState) {
                  return AppDisplayMessage.success(context, "Nhóm đã bị xóa");
                }
              },
              builder: (context, state) {
                if (state is DeleteGroupLoadingState) {
                  return const AppLoadingWidget();
                }
                return Row(
                  children: [
                    AppButtonWidget(
                      onPressed: () => Navigator.of(context).pop(),
                      title: "Đóng",
                      bgColor: AppColors.bgGray,
                    ),
                    AppButtonWidget(
                      onPressed: () {
                        context.read<GroupBloc>().add(DeleteGroupEvent(widget.groupId));
                      },
                      title: "Xóa",
                      bgColor: AppColors.bgPink,
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
