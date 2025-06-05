import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/common/widgets/avatar/app_avatar_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/comment_entity.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/comment/comment_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/interact/interact_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/comment/comment_delete_confirm_dialog_widget.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/comment/comment_replies_widget.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentWidget extends StatefulWidget {
  final String postId;
  final CommentEntity comment;
  final UserProfileEntity userInfo;
  final VoidCallback callback;
  final void Function(String)? onPressed;

  //final Function() onConfirm;

  const CommentWidget({
    super.key,
    required this.postId,
    required this.comment,
    required this.onPressed,
    required this.callback,
    required this.userInfo,
    //required this.onConfirm,
  });

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late int voteCount = widget.comment.votes;
  int? userVoteType;
  Color _upVoteColor = Colors.black;
  Color _downVoteColor = Colors.black;
  String? _activeCommentId;
  bool _showReplies = false;
  bool _isLoadingReplies = false;
  List<CommentEntity> _replies = [];

  void _toggleReplies() {
    setState(() {
      _showReplies = !_showReplies;
    });

    if (_showReplies && _replies.isEmpty) {
      setState(() {
        _isLoadingReplies = true;
      });

      context.read<CommentBloc>().add(
            FetchRepliesCommentEvent(parentCommentId: widget.comment.id),
          );
    }
  }

  @override
  void initState() {
    userVoteType = widget.comment.userVoteType;
    _upVoteColor =
        widget.comment.userVoteType == 1 ? AppColors.bgPink : Colors.black;
    _downVoteColor =
        widget.comment.userVoteType == 2 ? AppColors.bgPink : Colors.black;
    super.initState();
  }

  void _upVote() {
    setState(() {
      if (userVoteType == 1) {
        voteCount -= 1;
        _upVoteColor = Colors.black;
        userVoteType = null;
      } else {
        if (userVoteType == 2) voteCount += 2;
        if (userVoteType == null) voteCount += 1;
        _upVoteColor = AppColors.bgPink;
        _downVoteColor = Colors.black;
        userVoteType = 1;
      }
    });
    context.read<InteractBloc>().add(
          InteractCommentEvent(
            userId: widget.userInfo.userInfo.userId,
            commentId: widget.comment.id,
            voteType: 1,
          ),
        );
    logg.i('VoteType: 1');
  }

  void _downVote() {
    setState(() {
      if (userVoteType == 2) {
        voteCount += 1;
        _downVoteColor = Colors.black;
        userVoteType = null;
      } else {
        if (userVoteType == 1) voteCount -= 2;
        if (userVoteType == null) voteCount -= 1;
        _downVoteColor = AppColors.bgPink;
        _upVoteColor = Colors.black;
        userVoteType = 2;
      }
    });
    context.read<InteractBloc>().add(
          InteractCommentEvent(
            userId: widget.userInfo.userInfo.userId,
            commentId: widget.comment.id,
            voteType: 2,
          ),
        );
    logg.i('VoteType: 2');
  }

  void _unVote() {
    setState(() {
      if (userVoteType == 1) {
        voteCount -= 1;
      } else if (userVoteType == 2) {
        voteCount += 1;
      }
      _upVoteColor = Colors.black;
      _downVoteColor = Colors.black;
      userVoteType = null;
    });
    context.read<InteractBloc>().add(
          InteractCommentEvent(
            userId: widget.userInfo.userInfo.userId,
            commentId: widget.comment.id,
            voteType: 3,
          ),
        );
    logg.i('VoteType: 3');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.comment.user;
    final userInfo = widget.userInfo;
    final profileUrl =
        user?.profilePictureUrl ?? userInfo.userInfo.profilePictureUrl;
    final username = user?.username ?? userInfo.username;
    return BlocListener<CommentBloc, CommentState>(
      listener: (context, state) {
        final bloc = context.read<CommentBloc>();
        final repliesComment = bloc.repliesMap;
        logger.e("RepliesComment update: ${repliesComment.length}");
        if (state is FetchRepliesCommentSuccessState &&
            state.parentCommentId == widget.comment.id) {
          setState(() {
            _replies = state.data;
            _isLoadingReplies = false;
          });
        }

        if (state is FetchRepliesCommentFailureState && state.parentCommentId == widget.comment.id) {
          setState(() {
            _isLoadingReplies = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }

        if (state is FetchRepliesCommentLoadingState &&
            state.parentCommentId == widget.comment.id) {
          setState(() {
            _isLoadingReplies = true;
          });
        }
      },
      child: Column(
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
                          if (widget.comment.userId == userInfo.userInfo.userId)
                            InkWell(
                              onTap: () {
                                print('Current context: $context');
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CommentDeleteConfirmDialogWidget(
                                      postId: widget.postId,
                                      commentId: widget.comment.id,
                                    );
                                  },
                                );
                              },
                              child: const Icon(
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
                //_buildFavourite(widget.comment.votes),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (userVoteType == null) {
                          return _upVote();
                        } else if (userVoteType == 1) {
                          return _unVote();
                        } else if (userVoteType == 2) {
                          return _upVote();
                        }
                      },
                      padding: const EdgeInsets.all(0),
                      icon: Icon(
                        Icons.arrow_upward,
                        size: 20,
                        color: _upVoteColor,
                      ),
                    ),
                    Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.grey, width: 0),
                          ),
                        ),
                        child: Text(voteCount.toString())),
                    IconButton(
                      onPressed: () {
                        if (userVoteType == null) {
                          return _downVote();
                        } else if (userVoteType == 2) {
                          return _unVote();
                        } else if (userVoteType == 1) {
                          return _downVote();
                        }
                      },
                      icon: Icon(
                        Icons.arrow_downward,
                        size: 20,
                        color: _downVoteColor,
                      ),
                    ),
                  ],
                ),
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
                    onPressed: _toggleReplies,
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
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: _isLoadingReplies
                  ? const AppLoadingWidget()
                  : Column(
                children: _replies
                    .map((reply) => CommentRepliesWidget(
                  postId: widget.postId,
                  user: widget.comment.user!,
                  comment: reply,
                  userInfo: widget.userInfo,
                ))
                    .toList(),
              ),
            ),
        ],
      ),
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
