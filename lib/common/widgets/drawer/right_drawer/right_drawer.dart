import 'package:fitora_mobile_app/common/widgets/drawer/right_drawer/active_status.dart';
import 'package:fitora_mobile_app/common/widgets/drawer/right_drawer/right_drawer_option.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/navigation/app_navigation.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:forui/widgets/switch.dart';
import 'package:go_router/go_router.dart';

final List<Map<String, dynamic>> _option = [
  {
    "icon": Icons.account_circle_outlined,
    "title": "Trang cá nhân",
    "description": null,
    "route": "",
  },
  {
    "icon": Icons.group_add_outlined,
    "title": "Tạo một cộng đồng",
    "description": null,
    "route": "",
  },
  {
    "icon": Icons.stars_outlined,
    "title": "Chương trình cộng tác viên",
    "description": "Kiếm được 0 vàng",
    "route": "",
  },
  {
    "icon": Icons.lock_open,
    "title": "Kho tiền",
    "description": null,
    "route": "",
  },
  {
    "icon": Icons.workspace_premium,
    "title": "Fitora cao cấp",
    "description": "Không có quảng cáo",
    "route": "",
  },
  {
    "icon": Icons.bookmarks_outlined,
    "title": "Lưu",
    "description": null,
    "route": AppRoute.savedPost.name,
  },
  {
    "icon": Icons.history_toggle_off,
    "title": "Lịch sử",
    "description": null,
    "route": "",
  },
  {
    "icon": Icons.settings_outlined,
    "title": "Cài đặt",
    "description": null,
    "route": "",
  },
  {
    "icon": Icons.logout,
    "title": "Đăng xuất",
    "description": null,
    "route": "logout",
  },
];

Widget rightDrawer(BuildContext context) {
  return Drawer(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0),
      side: BorderSide.none,
    ),
    backgroundColor: AppColors.bgWhite,
    child: ListView(
      children: [
        // FSwitch(
        //   label: const Text('Airplane Mode'),
        //   semanticLabel: 'Airplane Mode',
        //   value: false,
        //   onChange: (value) {},
        // ),
        // SwitchListTile(
        //   title: Text('Chế đô tối'),
        //   value: false,
        //   onChanged: (value) {},
        // ),
        // SwitchListTile(
        //   title: Text(
        //     'Chế độ tối',
        //     style: TextStyle(
        //       fontSize: 16,
        //       fontWeight: FontWeight.w600,
        //     ),
        //   ),
        //   secondary: Icon(Icons.dark_mode, color: Colors.amber),
        //   value: false, // bool từ state
        //   onChanged: (value) {},
        //   contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        //   tileColor: Theme.of(context).colorScheme.surfaceVariant,
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(16),
        //   ),
        // ),
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        //   decoration: BoxDecoration(
        //     color: Theme.of(context).colorScheme.surfaceVariant,
        //     borderRadius: BorderRadius.circular(16),
        //   ),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Row(
        //         children: [
        //           Icon(Icons.dark_mode, color: Colors.amber),
        //           SizedBox(width: 12),
        //           Text(
        //             'Chế độ tối',
        //             style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        //           ),
        //         ],
        //       ),
        //       Transform.scale(
        //         scale: 0.7, // Thu nhỏ Switch
        //         child: Switch(
        //           value: true,
        //           onChanged: (value) {},
        //         ),
        //       ),
        //     ],
        //   ),
        // ),

        // Stack(
        //   children: [
        //     Center(
        //       child: SizedBox(
        //         height: 250,
        //         width: 220,
        //         child: Image.asset(
        //           AppImages.avatar,
        //           fit: BoxFit.cover,
        //         ),
        //       ),
        //     ),
        //     Positioned(
        //       top: 10,
        //       left: 10,
        //       child: styleAvatar(),
        //     ),
        //   ],
        // ),
        // Row(
        //   children: [
        //     Expanded(
        //         child: rightDrawerOption(Icons.ac_unit_outlined, "1", "Karma", () {})),
        //     Expanded(
        //         child: rightDrawerOption(
        //             Icons.account_balance_wallet, "0d", "Reddit age", () {})),
        //   ],
        // ),
        // achievements(),
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
              // if (i["route"] != null) {
              //   logger.i('Đã bấm vào: ${i["title"]}');
              //   Navigator.pop(context);
              //   AppNavigation.pushReplacement(context, i["route"]);
              // }
              if (i["route"] == "logout") {
                // Gọi logout
                // context.read<AuthBloc>().add(LogoutEvent());
                //AppNavigation.pushReplacement(context, AppRoute.auth.name);
                context.goNamed(AppRoute.auth.name);
              } else if (i["route"] != null &&
                  i["route"].toString().isNotEmpty) {
                logger.i('Đã bấm vào: ${i["title"]}');
                //ppNavigation.pushNamed(context, i["route"]);
                context.pushNamed(i['route']);
              }
            },
          ),
        ),
      ],
    ),
  );
}
