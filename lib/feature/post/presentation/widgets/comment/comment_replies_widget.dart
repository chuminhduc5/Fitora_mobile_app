import 'dart:io';
import 'package:fitora_mobile_app/common/widgets/avatar/app_avatar_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/comment_entity.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/interact/interact_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/widgets/comment/comment_delete_confirm_dialog_widget.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentRepliesWidget extends StatefulWidget {
  final String postId;
  final UserEntity user;
  final CommentEntity comment;
  final UserProfileEntity userInfo;
  //final VoidCallback onReplyTap;

  const CommentRepliesWidget({
    super.key,
    required this.postId,
    required this.user,
    required this.comment,
    //required this.onReplyTap,
    required this.userInfo,
  });

  @override
  State<CommentRepliesWidget> createState() => _CommentRepliesWidgetState();
}

class _CommentRepliesWidgetState extends State<CommentRepliesWidget> {
  late int voteCount = widget.comment.votes;
  int? userVoteType;
  Color _upVoteColor = Colors.black;
  Color _downVoteColor = Colors.black;

  @override
  void initState() {
    userVoteType = widget.comment.userVoteType;
    _upVoteColor = widget.comment.userVoteType == 1 ? AppColors.bgPink : Colors.black;
    _downVoteColor = widget.comment.userVoteType == 2 ? AppColors.bgPink : Colors.black;
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
    logger.i("Upvote vote - Vote Type: 3 - CommentId: ${widget.comment.id}");
  }

  void _downVote() {
    setState(() {
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
    });
    context.read<InteractBloc>().add(
      InteractCommentEvent(
        userId: widget.userInfo.userInfo.userId,
        commentId: widget.comment.id,
        voteType: 2,
      ),
    );
    logger.i("Down vote - Vote Type: 2 - CommentId: ${widget.comment.id}");
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
    logger.i("Un vote - Vote Type: 3 - CommentId: ${widget.comment.id}");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.comment.user;
    final userInfo = widget.userInfo;
    final profileUrl = user?.profilePictureUrl ?? userInfo.userInfo.profilePictureUrl;
    final username = user?.username ?? userInfo.username;
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppAvatarWidget(
                imagePath: profileUrl,
                size: 30,
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
                        children: [
                          RichText(
                            text: TextSpan(
                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                  text: username,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                TextSpan(
                                  text: " @${widget.user.username}",
                                  style: const TextStyle(color: Colors.blue),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          if (widget.comment.userId == userInfo.userInfo.userId)
                            InkWell(
                              onTap: () {
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
                      icon: Icon(Icons.arrow_upward, size: 20, color: _upVoteColor,),
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
                        logger.i("Đã bấm down vote");
                        if (userVoteType == null) {
                          return _downVote();
                        } else if (userVoteType == 2) {
                          return _unVote();
                        } else if (userVoteType == 1) {
                          return _downVote();
                        }
                      },
                      icon: Icon(Icons.arrow_downward, size: 20, color: _downVoteColor,),
                    ),
                  ],
                ),
              ],
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
