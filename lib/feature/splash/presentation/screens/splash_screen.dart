import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.bgPink,
      body: Center(
        child: Text(
          "Fitora",
          style: TextStyle(
            color: AppColors.white,
            fontSize: 40,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
