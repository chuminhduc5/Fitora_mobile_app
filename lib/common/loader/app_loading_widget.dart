import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppLoadingWidget extends StatelessWidget {
  const AppLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.bgPink,
        backgroundColor: AppColors.bgWhite,
      ),
    );
  }
}
