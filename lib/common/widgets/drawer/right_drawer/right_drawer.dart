import 'package:fitora_mobile_app/common/widgets/drawer/right_drawer/achievements.dart';
import 'package:fitora_mobile_app/common/widgets/drawer/right_drawer/active_status.dart';
import 'package:fitora_mobile_app/common/widgets/drawer/right_drawer/right_drawer_option.dart';
import 'package:fitora_mobile_app/common/widgets/drawer/right_drawer/style_avatar.dart';
import 'package:fitora_mobile_app/core/config/assets/app_images.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/screens/personal_screen.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> _option = [
  {
    "icon": Icons.account_circle_outlined,
    "title": "Trang cá nhân",
    "description": null,
    "route": PersonalScreen(),
  },
  {
    "icon": Icons.group_add_outlined,
    "title": "Tạo một cộng đồng",
    "description": null,
    "route": PersonalScreen(),
  },
  {
    "icon": Icons.stars_outlined,
    "title": "Chương trình cộng tác viên",
    "description": "Kiếm được 0 vàng",
    "route": PersonalScreen(),
  },
  {
    "icon": Icons.lock_open,
    "title": "Kho tiền",
    "description": null,
    "route": PersonalScreen(),
  },
  {
    "icon": Icons.workspace_premium,
    "title": "Fitora cao cấp",
    "description": "Không có quảng cáo",
    "route": PersonalScreen(),
  },
  {
    "icon": Icons.bookmarks_outlined,
    "title": "Lưu",
    "description": null,
    "route": PersonalScreen(),
  },
  {
    "icon": Icons.history_toggle_off,
    "title": "Lịch sử",
    "description": null,
    "route": PersonalScreen(),
  },
  {
    "icon": Icons.settings_outlined,
    "title": "Cài đặt",
    "description": null,
    "route": PersonalScreen(),
  },
];

Widget rightDrawer(BuildContext context) {
  return Drawer(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0),
      side: BorderSide.none,
    ),
    child: ListView(
      children: [
        Stack(
          children: [
            Center(
              child: SizedBox(
                height: 250,
                width: 220,
                child: Image.asset(
                  AppImages.avatar,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: styleAvatar(),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
                child: rightDrawerOption(Icons.ac_unit_outlined, "1", "Karma", () {})),
            Expanded(
                child: rightDrawerOption(
                    Icons.account_balance_wallet, "0d", "Reddit age", () {})),
          ],
        ),
        achievements(),
        const SizedBox(
          height: 10,
        ),
        activeStatus(Colors.green, 'Đang hoạt động'),
        ..._option.map(
          (i) => rightDrawerOption(
            i["icon"],
            i["title"],
            i["description"],
            () {
              if (i["route"] != null) {
                logger.i('Đã bấm vào: ${i["title"]}');
                Navigator.pop(context); // Đóng drawer trước
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => i["route"]),
                );
              }
            },
          ),
        ),
      ],
    ),
  );
}
