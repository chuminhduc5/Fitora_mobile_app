import 'dart:io';
import 'package:fitora_mobile_app/common/widgets/avatar/app_avatar_widget.dart';
import 'package:fitora_mobile_app/common/widgets/button/app_button_widget.dart';
import 'package:fitora_mobile_app/core/config/assets/app_images.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_profile_entity.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class ProfileInfoWidget extends StatelessWidget {
  final UserProfileEntity profile;

  const ProfileInfoWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            clipBehavior: Clip.none,
            children: [
              // Cover Photo
              Container(
                height: 200,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.bgImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Avatar (nằm ngoài Positioned, nhưng đè nhờ Positioned hoặc transform)
              Positioned(
                bottom: -50, // đẩy avatar ra khỏi stack để đè xuống dưới
                left: 16,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: AppAvatarWidget(
                    imagePath: profile.userInfo.profilePictureUrl,
                    size: 120,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 55),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              profile.username,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildInFoItem("Đã follow", profile.followingCount.toString()),
                _buildInFoItem("Follower", profile.followerCount.toString()),
                _buildInFoItem("Bạn bè", ""),
              ],
            ),
          ),
          // const SizedBox(height: 10),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     _statItem("0", "Followers"),
          //     _buildVerticalLine(),
          //     _statItem("0", "Following"),
          //     _buildVerticalLine(),
          //     _statItem("0", "Bạn bè")
          //   ],
          // ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _button(() {}, "Thông tin", AppColors.bgPink, Colors.white),
              const SizedBox(width: 10),
              _button(
                    () {
                  context.pushNamed(AppRoute.updateProfile.name,
                      extra: profile);
                },
                "Chỉnh sửa",
                Colors.white,
                Colors.black,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle("Về tôi"),
                const Text(
                  "Trở thành 1 lập trình viên Mobile Developer!",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 20),
                _sectionTitle("QUAN TÂM"),
                _buildInterests(),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInFoItem(String title, String value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _statItem(String count, String label) {
    return Column(
      children: [
        Text(count,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildVerticalLine() {
    return const SizedBox(
      height: 25,
      child: VerticalDivider(
        thickness: 1,
        color: Colors.grey,
        width: 0,
      ),
    );
  }

  Widget _button(
      Function() onPressed, String text, Color bgColor, Color textColor) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.black, width: 0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.5),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor, fontSize: 14),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }

  Widget _buildInterests() {
    List<String> interests = [
      "JavaScript",
      "Flutter",
      ".NET",
      "SQL Server",
      "MY SQL",
      "Web",
      "App"
    ];

    List<Color> backgroundColors = [
      Colors.purple.shade100,
      Colors.blue.shade100,
      Colors.green.shade100,
      Colors.yellow.shade100,
      Colors.orange.shade100,
      Colors.red.shade100,
      Colors.cyan.shade100
    ];

    List<Color> textColors = [
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.yellow[800]!,
      Colors.orange[800]!,
      Colors.red[800]!,
      Colors.cyan[800]!
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: List.generate(interests.length, (index) {
        return Container(
          decoration: BoxDecoration(
            color: backgroundColors[index],
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Text(
            interests[index],
            style: TextStyle(color: textColors[index], fontSize: 14),
          ),
        );
      }),
    );
  }
}
