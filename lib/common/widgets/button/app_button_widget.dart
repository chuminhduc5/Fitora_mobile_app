import 'package:flutter/material.dart';

import '../../../core/config/theme/app_colors.dart';

class AppButtonWidget extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  final Color color;
  final double? fontSize;
  final FontWeight fontWeight;
  final Color bgColor;
  final double paddingTop;
  final double paddingBottom;
  final double paddingRight;
  final double paddingLeft;
  final int? borderRadius;
  final bool isLoading;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const AppButtonWidget({
    super.key,
    required this.onPressed,
    required this.title,
    this.color = AppColors.bgWhite,
    this.fontSize = 13,
    this.fontWeight = FontWeight.normal,
    this.bgColor = AppColors.bgBlue,
    this.paddingTop = 0,
    this.paddingBottom = 0,
    this.paddingRight = 0,
    this.paddingLeft = 0,
    this.borderRadius = 10,
    this.isLoading = false,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: color,
        backgroundColor: bgColor,
        padding: EdgeInsets.fromLTRB(
          paddingLeft,
          paddingTop,
          paddingRight,
          paddingBottom,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : (title.isEmpty
              ? Center(child: prefixIcon ?? const SizedBox())
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (prefixIcon != null) prefixIcon!,
                    if (prefixIcon != null) const SizedBox(width: 4),
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: fontSize,
                        color: color,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (suffixIcon != null) const SizedBox(width: 4),
                    if (suffixIcon != null) suffixIcon!,
                  ],
                )),
    );
  }
}
