import 'package:fitora_mobile_app/core/config/assets/app_images.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/screens/sign_in_screen.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppImages.logo, width: 50, height: 50),
                  const Text(
                    'Fitora',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.bgPink,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Chào mừng đến với Fitora',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 10),
                child: Text(
                  'Đăng nhập hoặc tạo tài khoản để bắt đầu hành trình học tập, kết nối bạn bè và nâng cao hiệu quả mỗi ngày cùng Fitora.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              TabBar(
                indicatorWeight: 2,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: AppColors.bgPink,
                indicatorColor: AppColors.bgPink,
                unselectedLabelColor: Colors.grey[400],
                tabs: const [
                  Tab(text: 'Đăng nhập'),
                  Tab(text: 'Đăng ký'),
                ],
                // onTap: (index) {
                //   if (index == 0) {
                //     context.goNamed(AppRoute.signIn.name);
                //   } else {
                //     context.goNamed(AppRoute.signUp.name);
                //   }
                // },
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    SignInScreen(),
                    SignUpScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
