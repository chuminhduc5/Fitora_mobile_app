import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/button/app_button_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/post/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDeleteConfirmWidget extends StatefulWidget {
  final String postId;
  const PostDeleteConfirmWidget({super.key, required this.postId});

  @override
  State<PostDeleteConfirmWidget> createState() => _PostDeleteConfirmWidgetState();
}

class _PostDeleteConfirmWidgetState extends State<PostDeleteConfirmWidget> {
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
            'Bạn có chắc chắn muốn xóa bài viết?',
            style: TextStyle(fontSize: 22),
          ),
          actions: <Widget>[
            BlocConsumer<PostBloc, PostState>(
              listener: (context, state) {
                if (state is DeletePostFailureState) {
                  AppDisplayMessage.error(context, state.message);
                } else if (state is DeletePostSuccessState) {
                  Navigator.of(context).pop();
                  return AppDisplayMessage.success(context, "Nhóm đã bị xóa");
                }
              },
              builder: (context, state) {
                if (state is DeletePostLoadingState) {
                  return const AppLoadingWidget();
                }
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AppButtonWidget(
                      onPressed: () => Navigator.of(context).pop(),
                      title: "Đóng",
                      bgColor: AppColors.bgGray,
                    ),
                    const SizedBox(width: 10),
                    AppButtonWidget(
                      onPressed: () {
                        context.read<PostBloc>().add(DeletePostEvent(postId: widget.postId));
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

