import 'package:fitora_mobile_app/core/config/assets/app_svg.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PasswordConditionWidget extends StatelessWidget {
  final String title;
  final bool condition;

  const PasswordConditionWidget({
    super.key,
    required this.title,
    this.condition = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          SvgPicture.asset(
            AppSvg.check,
            height: 18,
            width: 18,
            color: condition ? AppColors.bgPink : Colors.grey,
          ),
          const SizedBox(width: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: condition ? AppColors.bgPink : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
