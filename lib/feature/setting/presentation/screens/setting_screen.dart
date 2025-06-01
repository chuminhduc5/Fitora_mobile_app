import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/setting_option_widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cài đặt"),
        backgroundColor: AppColors.bgWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.grey,
            size: 20,
          ),
          // onPressed: () => context.goNamed(AppRoute.appView.name),
          onPressed: () => context.pop(),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
              margin: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.bgWhite,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  SettingOptionWidget(
                    icon: Icons.person,
                    title: 'Thông tin cá nhân',
                    onTap: () {

                    },
                    color: Colors.blue,
                  ),
                  SettingOptionWidget(
                    icon: Icons.calendar_today,
                    title: 'Lịch thi, sự kiện sắp tới',
                    onTap: () {
                      // Handle tap
                    },
                    color: Colors.red,
                  ),
                  SettingOptionWidget(
                    icon: Icons.feedback,
                    title: 'Đang chờ phản hồi',
                    onTap: () {
                      // Handle tap
                    },
                    color: Colors.orange,
                  ),
                  SettingOptionWidget(
                    icon: Icons.people,
                    title: 'Mạng xã hội DNU',
                    onTap: () {
                      // Handle tap
                    },
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
