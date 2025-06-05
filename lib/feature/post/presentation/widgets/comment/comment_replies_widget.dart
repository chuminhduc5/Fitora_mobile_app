import 'dart:io';
import 'package:fitora_mobile_app/common/widgets/avatar/app_avatar_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/post/domain/entities/comment_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_profile_entity.dart';
import 'package:flutter/material.dart';

class CommentRepliesWidget extends StatefulWidget {
  final CommentEntity comment;
  final UserProfileEntity userInfo;
  //final VoidCallback onReplyTap;

  const CommentRepliesWidget({
    super.key,
    required this.comment,
    //required this.onReplyTap,
    required this.userInfo,
  });

  @override
  State<CommentRepliesWidget> createState() => _CommentRepliesWidgetState();
}

class _CommentRepliesWidgetState extends State<CommentRepliesWidget> {
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
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(
                              text: username,
                              style: const TextStyle(color: Colors.black),
                            ),
                            TextSpan(
                              text: " @${widget.userInfo.username}",
                              style: const TextStyle(color: Colors.blue),
                            ),
                          ],
                        ),
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
