import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppLoadingWidget extends StatelessWidget {
  final Color color;
  const AppLoadingWidget({super.key, this.color = AppColors.bgPink});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
        backgroundColor: AppColors.bgWhite,
      ),
    );
  }
}
