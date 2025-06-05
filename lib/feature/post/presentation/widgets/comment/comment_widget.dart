import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/avatar/app_avatar_widget.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/comment_entity.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/comment/comment_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/comment/comment_replies_widget.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentWidget extends StatefulWidget {
  final CommentEntity comment;
  final UserProfileEntity userInfo;
  final VoidCallback callback;
  final void Function(String)? onPressed;

  const CommentWidget({
    super.key,
    required this.comment,
    required this.onPressed,
    required this.callback,
    required this.userInfo,
  });

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  bool _showReplies = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.comment.user;
    final userInfo = widget.userInfo;
    logg.i("Thông tin người dùng: $user");
    final profileUrl =
        user?.profilePictureUrl ?? userInfo.userInfo.profilePictureUrl;
    final username = user?.username ?? userInfo.username;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppAvatarWidget(
              imagePath: profileUrl,
              size: 40,
            ),
            const SizedBox(width: 3),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.close,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.comment.content,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Row(
            children: [
              _buildFavourite(widget.comment.votes),
              const SizedBox(width: 5),
              TextButton(
                onPressed: () {
                  widget.callback();
                  widget.onPressed?.call(widget.comment.id);
                },
                child: const Text(
                  'Phản hồi',
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
              if (widget.comment.replyCount > 0)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showReplies = !_showReplies;
                      logger.i("ShowReplies: $_showReplies");
                    });
                    if (_showReplies) {
                      context.read<CommentBloc>().add(FetchRepliesCommentEvent(
                          parentCommentId: widget.comment.id));
                    }
                  },
                  child: Text(
                    _showReplies
                        ? 'Ẩn ${widget.comment.replyCount} phản hồi'
                        : 'Xem ${widget.comment.replyCount} phản hồi',
                    style: const TextStyle(color: Colors.black, fontSize: 12),
                  ),
                ),
            ],
          ),
        ),
        if (_showReplies)
          BlocBuilder<CommentBloc, CommentState>(
            builder: (context, state) {
              logger.e("Current State: $state");
              if (state is FetchRepliesCommentLoadingState) {
                return const AppLoadingWidget();
              } else if (state is FetchRepliesCommentFailureState) {
                return AppErrorWidget(state.message);
              } else if (state is FetchRepliesCommentSuccessState) {
                final replies =
                    context.read<CommentBloc>().getReplies(widget.comment.id);
                logger.i("Replies Comment: $replies");
                if (replies.isEmpty) {
                  logger.i("Replies Comment: $replies");
                  return const SizedBox(
                    child: Text('Empty'),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    children: replies.map((reply) {
                      return CommentRepliesWidget(
                        comment: reply,
                        userInfo: widget.userInfo,
                      );
                    }).toList(),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
      ],
    );
  }

  Widget _buildFavourite(int? favouriteCount) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          padding: const EdgeInsets.all(0),
          icon: const Icon(Icons.arrow_upward, size: 20),
        ),
        Container(
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.grey, width: 0),
              ),
            ),
            child: Text(favouriteCount.toString())),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_downward, size: 20),
        ),
      ],
    );
  }
}
