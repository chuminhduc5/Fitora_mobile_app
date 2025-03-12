import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/routes/app_route_path.dart';

class UserInfoWidget extends StatelessWidget {
  final String username;
  const UserInfoWidget({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 60.r,
                        // backgroundImage: const NetworkImage(
                        //     'https://i.imgur.com/5M37i3l.jpg'),
                        child: Image.network("https://localhost:5005/uploads/1ce5a1cd-7768-46bd-b283-c6db18516151_TikVideo.app_7348465457374006535_3.jpeg"),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "$username | Mobile Developer",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Trở thành 1 lập trình viên mobile app!",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 12,
                          spreadRadius: 0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: [
                        _buildInFoItem("Công việc", "Developer"),
                        _buildInFoItem("Năm sinh", "2003"),
                        _buildInFoItem("Quê Quán", "Hà Nội"),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _statItem("0", "Followers"),
              _buildVerticalLine(),
              _statItem("0", "Following"),
              _buildVerticalLine(),
              _statItem("0", "Bạn bè")
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _button(
                      () {}, "Thông tin", AppColors.bgPink, Colors.white),
              const SizedBox(width: 10),
              _button(
                    () {
                  context.goNamed(AppRoute.editProfile.name);
                },
                "Chỉnh sửa",
                Colors.white,
                Colors.black,
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionTitle("Về tôi"),
                const Text(
                  "I believe that no one should ever have to choose between a career we love and living our lives with authenticity and integrity",
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
      crossAxisAlignment: CrossAxisAlignment.start,
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

  Widget _button(Function() onPressed, String text, Color bgColor, Color textColor) {
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
