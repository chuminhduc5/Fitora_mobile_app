import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

class RecommendFriendWidget extends StatelessWidget {
  final String friend;
  final Function()? onPressed;

  const RecommendFriendWidget({
    super.key,
    required this.friend,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FAvatar(
            //   image: const AssetImage(AppImages.avatarAnime),
            //   size: 60,
            // ),
            // const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Gợi ý kết bạn dành cho bạn",
                    softWrap: true,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),
                  // const Text(
                  //   "7 giờ - 10 bạn chung",
                  //   style: TextStyle(color: Colors.grey, fontSize: 12),
                  // ),
                ],
              ),
            ),
            // IconButton(
            //   padding: EdgeInsets.zero,
            //   onPressed: () {},
            //   icon: const Icon(
            //     Icons.more_horiz,
            //     size: 20,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}