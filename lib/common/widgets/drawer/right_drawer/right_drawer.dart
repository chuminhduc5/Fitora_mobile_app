import 'package:fitora_mobile_app/common/widgets/drawer/right_drawer/achievements.dart';
import 'package:fitora_mobile_app/common/widgets/drawer/right_drawer/active_status.dart';
import 'package:fitora_mobile_app/common/widgets/drawer/right_drawer/right_drawer_option.dart';
import 'package:fitora_mobile_app/common/widgets/drawer/right_drawer/style_avatar.dart';
import 'package:fitora_mobile_app/core/config/assets/app_images.dart';
import 'package:flutter/material.dart';

final List<Map<String, dynamic>> _option = [
  {
    "icon": Icons.account_circle_outlined,
    "title": "Trang cá nhân",
    "desciption": null,
  },
  {
    "icon": Icons.group_add_outlined,
    "title": "Tạo một cộng đồng",
    "description": null,
  },
  {
    "icon": Icons.stars_outlined,
    "title": "Chương trình cộng tác viên",
    "description": "Kiếm được 0 vàng",
  },
  {
    "icon": Icons.lock_open,
    "title": "Kho tiền",
    "description": null,
  },
  {
    "icon": Icons.workspace_premium,
    "title": "Fitora cao cấp",
    "description": "Không có quảng cáo",
  },
  {
    "icon": Icons.bookmarks_outlined,
    "title": "Lưu",
    "description": null,
  },
  {
    "icon": Icons.history_toggle_off,
    "title": "Lịch sử",
    "description": null,
  },
  {
    "icon": Icons.settings_outlined,
    "title": "Cài đặt",
    "description": null,
  },
];

Widget rightDrawer() {
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
                height: 250, width: 220,
                child: Image.asset(AppImages.avatar, fit: BoxFit.cover,),
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
            Expanded(child: rightDrawerOption(Icons.ac_unit_outlined, "1", "Karma")),
            Expanded(child: rightDrawerOption(Icons.account_balance_wallet, "0d", "Reddit age")),
          ],
        ),
        achievements(),
        const SizedBox(height: 10,),
        activeStatus(Colors.green, 'Đang hoạt động'),
        ..._option.map((i) => rightDrawerOption(i["icon"], i["title"], i["description"])),
      ],
    ),
  );
}
