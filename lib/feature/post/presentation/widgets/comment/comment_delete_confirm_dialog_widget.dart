import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/button/app_button_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/comment/comment_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CommentDeleteConfirmDialogWidget extends StatefulWidget {
  final String postId;
  final String commentId;

  const CommentDeleteConfirmDialogWidget({
    super.key,
    required this.postId,
    required this.commentId,
  });

  @override
  State<CommentDeleteConfirmDialogWidget> createState() =>
      _CommentDeleteConfirmDialogWidgetState();
}

class _CommentDeleteConfirmDialogWidgetState extends State<CommentDeleteConfirmDialogWidget> {

  void _deleteComment(BuildContext context) {
    context.read<CommentBloc>().add(
          DeleteCommentEvent(
            id: widget.commentId,
            postId: widget.postId,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
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
        'Bạn có chắc chắn muốn xóa phản hồi này?',
        style: TextStyle(fontSize: 22),
      ),
      actions: <Widget>[
        BlocConsumer<CommentBloc, CommentState>(
          listener: (context, state) {
            if (state is DeleteCommentFailureState) {
              AppDisplayMessage.error(context, state.message);
            } else if (state is DeleteCommentSuccessState) {
              Navigator.of(context).pop();
              context
                  .read<CommentBloc>()
                  .add(FetchCommentEvent(postId: widget.postId));
              return AppDisplayMessage.success(context, "Bình luận đã bị xóa");
            }
          },
          builder: (context, state) {
            if (state is DeleteCommentLoadingState) {
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
                  onPressed: () => _deleteComment(context),
                  title: "Xóa",
                  bgColor: AppColors.bgPink,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
