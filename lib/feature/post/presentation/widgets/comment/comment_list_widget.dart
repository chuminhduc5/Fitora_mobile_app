// import 'package:fitora_mobile_app/feature/post/domain/entities/comment_entity.dart';
// import 'package:fitora_mobile_app/feature/post/presentation/widgets/comment/comment_widget.dart';
// import 'package:fitora_mobile_app/feature/user/domain/entities/user_profile_entity.dart';
// import 'package:flutter/material.dart';
//
// class CommentListWidget extends StatelessWidget {
//   final List<CommentEntity> comments;
//   final Map<String, List<CommentEntity>> repliesComments;
//   final UserProfileEntity userInfo;
//   final VoidCallback callback;
//   final void Function(String)? onPressed;
//   final VoidCallback onShowReplies;
//
//   const CommentListWidget({
//     super.key,
//     required this.comments,
//     required this.repliesComments,
//     required this.onPressed,
//     required this.callback,
//     required this.userInfo,
//     required this.onShowReplies,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverList(
//           delegate: SliverChildBuilderDelegate(
//             (context, index) {
//               final comment = comments[index];
//               final replies = repliesComments[comment.id] ?? [];
//
//               return CommentWidget(
//                 comment: comment,
//                 replies: replies,
//                 onPressed: () => ,
//                 callback: callback,
//                 userInfo: userInfo,
//                 onShowReplies: onShowReplies,
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
