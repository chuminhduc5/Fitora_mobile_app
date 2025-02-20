import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SelectCommunityWidget extends StatelessWidget {
  final Function() onPressed;
  final Widget icon;
  final String? community;

  const SelectCommunityWidget({
    super.key,
    required this.onPressed,
    required this.icon,
    this.community,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            Text(community ?? 'Lựa chọn cộng đồng', style: const TextStyle(color: AppColors.white),),
            const Icon(Icons.unfold_more, color: AppColors.white,)
          ],
        ),
      ),
    );
  }
}
