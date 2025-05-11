// import 'package:flutter/material.dart';
//
// enum Status { none, accept, deleted }
//
// class FriendInvitationCardWidget extends StatefulWidget {
//   final RecommendUserEntity user;
//   final Function()? onPressed;
//
//   const FriendInvitationCardWidget({
//     super.key,
//     required this.user,
//     this.onPressed,
//   });
//
//   @override
//   State<FriendInvitationCardWidget> createState() =>
//       _FriendInvitationCardWidgetState();
// }
//
// class _FriendInvitationCardWidgetState
//     extends State<FriendInvitationCardWidget> {
//
//   Status status = Status.none;
//
//   void _addFriend(BuildContext context) {
//     final userId = widget.user.id;
//     print("Call addFriend with userId: $userId");
//     context.read<FriendBloc>().add(AddFriendEvent(userId));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: widget.onPressed,
//       child: Container(
//         width: MediaQuery
//             .of(context)
//             .size
//             .width,
//         padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             FAvatar(
//               image: const NetworkImage(""),
//               size: 80,
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.user.username,
//                     softWrap: true,
//                     maxLines: 2,
//                   ),
//                   const SizedBox(height: 4),
//                   const Text(
//                     "7 giờ - 10 bạn chung",
//                     style: TextStyle(color: Colors.grey, fontSize: 12),
//                   ),
//                   if (status == Status.accept) ...[
//                     const Text("Đã gửi lời mời kết bạn"),
//                     const SizedBox(height: 10),
//                   ],
//                   if (status == Status.deleted) ...[
//                     const Text('Đã xóa người dùng khỏi danh sách'),
//                     const SizedBox(height: 10),
//                   ],
//                   if (status != Status.accept && status != Status.deleted) ...[
//                     Row(
//                       children: [
//                         BlocConsumer<FriendBloc, FriendState>(
//                           listener: (context, state) {
//                             if (state is AddFriendFailureState) {
//                               AppDisplayMessage.error(context, state.message);
//                             } else if (state is AddFriendSuccessState) {
//                               context.read<FriendBloc>().add(FetchRecommendUserEvent());
//                               logg.i("Đã gửi lời mời kết bạn");
//                               setState(() {
//                                 status = Status.accept;
//                               });
//                             }
//                           },
//                           builder: (context, state) {
//                             if (state is AddFriendLoadingState) {
//                               return const AppLoadingWidget();
//                             }
//                             return SizedBox(
//                               width: 120,
//                               child: AppButtonWidget(
//                                 onPressed: () {
//                                   //_addFriend(context);
//                                   setState(() {
//                                     status = Status.accept;
//                                   });
//                                 },
//                                 title: "Kết bạn",
//                                 bgColor: AppColors.bgPink,
//                               ),
//                             );
//                           },
//                         ),
//                         const SizedBox(width: 10),
//                         SizedBox(
//                           width: 120,
//                           child: AppButtonWidget(
//                             onPressed: () {
//                               setState(() {
//                                 status = Status.deleted;
//                               });
//                             },
//                             title: "Xóa",
//                             bgColor: Colors.grey[200]!,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     )
//                   ]
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }