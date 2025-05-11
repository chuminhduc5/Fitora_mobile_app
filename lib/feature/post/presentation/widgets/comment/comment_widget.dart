import 'dart:io';

import 'package:fitora_mobile_app/feature/post/domain/entities/comment_entity.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final CommentEntity comment;
  const CommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundImage:
              FileImage(File(comment.user.profilePictureUrl)),
            ),
            const SizedBox(width: 8),
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
                        Text(
                          comment.user.username,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 4),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 6, vertical: 2),
                        //   decoration: BoxDecoration(
                        //     color: Colors.blue.shade50,
                        //     borderRadius: BorderRadius.circular(8),
                        //   ),
                        //   child: const Text(
                        //     'Tác giả',
                        //     style: TextStyle(
                        //         fontSize: 10,
                        //         color: Colors.blue,
                        //         fontWeight: FontWeight.w600),
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      comment.content,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(left: 50),
          child: Row(
            children: [
              Text('7 giờ',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              const SizedBox(width: 16),
              Text('Thích',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
              const SizedBox(width: 16),
              Text('Trả lời',
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
