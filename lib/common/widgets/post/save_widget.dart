// import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
// import 'package:flutter/material.dart';
//
// class SaveWidget extends StatelessWidget {
//   final String postId;
//   final bool actionSavedPost;
//   final void Function(String)? savePost;
//
//   const SaveWidget({
//     super.key,
//     required this.postId,
//     this.actionSavedPost = false,
//     this.savePost,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 35,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey, width: 0),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: IconButton(
//         onPressed: () => savePost?.call(postId),
//         icon: Icon(
//           actionSavedPost ? Icons.bookmarks : Icons.bookmarks_outlined,
//           size: 20,
//           color: actionSavedPost ? AppColors.lightYellow : AppColors.black,
//         ),
//       ),
//     );
//   }
// }
