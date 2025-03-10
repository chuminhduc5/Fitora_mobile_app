import 'package:fitora_mobile_app/common/widgets/button/app_button_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/extensions/integer_sizebox_extension.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/widgets/edit_profile_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chỉnh sửa hồ sơ"),
        backgroundColor: AppColors.bgWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.grey,
            size: 20,
          ),
          onPressed: () => context.goNamed(AppRoute.profile.name),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60.r,
                    backgroundImage:
                        const NetworkImage('https://i.imgur.com/5M37i3l.jpg'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 15.r,
                      backgroundColor: Colors.white,
                      child: const Icon(Icons.camera_alt_outlined, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const EditProfileFormWidget(),
            30.hS,
            SizedBox(
              width: double.infinity,
              child: AppButtonWidget(
                onPressed: () {},
                title: "Lưu thay đổi",
                bgColor: AppColors.bgPink,
                paddingTop: 15,
                paddingBottom: 15,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
