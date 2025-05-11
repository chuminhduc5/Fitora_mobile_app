import 'package:fitora_mobile_app/core/config/assets/app_images.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FriendListWidget extends StatelessWidget {
  const FriendListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 100,
      ),
      child: _buildLayoutImage(),
    );
  }

  Widget _buildLayoutImage() {
    final List<String> imageUrls = [
      // AppImages.bgImage,
      // AppImages.bgImage,
      // AppImages.bgImage,
      // AppImages.bgImage,
      AppImages.bgImage,
    ];

    final List<String> username = [
      // 'Chử Minh Đức',
      // 'Chử Minh Đức',
      // 'Chử Minh Đức',
      // 'Chử Minh Đức',
      'Nguyễn Thế Huy Hoàng',
    ];

    final bool hasLongUsername = username.any((text) => text.length >= 18);
    final double aspectRatio = hasLongUsername ? 0.8 : 0.9;

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: imageUrls.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 10,
        childAspectRatio: aspectRatio,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            context.pushNamed(AppRoute.personal.name);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imageUrls[index],
                  width: 115,
                  height: 115,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                username[index],
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
