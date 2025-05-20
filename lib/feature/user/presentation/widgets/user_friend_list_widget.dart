import 'dart:io';

import 'package:fitora_mobile_app/common/dialog/app_error_widget.dart';
import 'package:fitora_mobile_app/core/config/assets/app_images.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/friend_entity.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/friend/friend_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UserFriendListWidget extends StatefulWidget {
  const UserFriendListWidget({super.key});

  @override
  State<UserFriendListWidget> createState() => _UserFriendListWidgetState();
}

class _UserFriendListWidgetState extends State<UserFriendListWidget> {
  late FriendBloc _friendBloc;

  @override
  void initState() {
    // _friendBloc = getIt<FriendBloc>()..add(FetchFriendEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FriendBloc>()..add(FetchFriendEvent()),
      child: BlocBuilder<FriendBloc, FriendState>(builder: (context, state) {
        if (state is FetchFriendLoadingState) {

        } else if (state is FetchFriendFailureState) {
          return AppErrorWidget(state.message);
        } else if (state is FetchFriendSuccessState) {
          final friends = state.data;
          return GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: friends.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final friend = friends[index];
              return InkWell(
                onTap: () {
                  context.pushNamed(AppRoute.personal.name);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ClipRRect(
                    //   borderRadius: BorderRadius.circular(12),
                    //   child: FileImage(
                    //     friend.profilePictureUrl,
                    //     width: 115,
                    //     height: 115,
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        File(friend.profilePictureUrl),
                        width: 115,
                        height: 115,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      friend.username,
                      style: const TextStyle(color: Colors.black, fontSize: 12),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const SizedBox();
      }),
    );
  }

  // Widget _buildLayoutImage(FriendEntity friend) {
  //   final bool hasLongUsername = friend.username.any((text) => text.length >= 18);
  //   final double aspectRatio = hasLongUsername ? 0.8 : 0.9;
  //
  //   return GridView.builder(
  //     shrinkWrap: true,
  //     padding: EdgeInsets.zero,
  //     physics: const NeverScrollableScrollPhysics(),
  //     itemCount: imageUrls.length,
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 3,
  //       crossAxisSpacing: 8,
  //       mainAxisSpacing: 10,
  //       childAspectRatio: aspectRatio,
  //     ),
  //     itemBuilder: (context, index) {
  //       return InkWell(
  //         onTap: () {
  //           context.pushNamed(AppRoute.personal.name);
  //         },
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             ClipRRect(
  //               borderRadius: BorderRadius.circular(12),
  //               child: Image.asset(
  //                 imageUrls[index],
  //                 width: 115,
  //                 height: 115,
  //                 fit: BoxFit.cover,
  //               ),
  //             ),
  //             Text(
  //               username[index],
  //               style: const TextStyle(color: Colors.black, fontSize: 12),
  //               softWrap: true,
  //               maxLines: 2,
  //               overflow: TextOverflow.ellipsis,
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

// Widget _buildFriendCard(>) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       ClipRRect(
//         borderRadius: BorderRadius.circular(12),
//         child: Image.asset(
//           imageUrls[index],
//           width: 115,
//           height: 115,
//           fit: BoxFit.cover,
//         ),
//       ),
//       Text(
//         username[index],
//         style: const TextStyle(color: Colors.black, fontSize: 12),
//         softWrap: true,
//         maxLines: 2,
//         overflow: TextOverflow.ellipsis,
//       ),
//     ],
//   );
// }
}
