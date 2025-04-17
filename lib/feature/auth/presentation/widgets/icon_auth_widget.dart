import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconAuthWidget extends StatelessWidget {
  final Function() onPressed;
  final String title;
  final String icon;

  const IconAuthWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // return GestureDetector(
    //   onTap: onPressed,
    //   child: Container(
    //     padding: const EdgeInsets.all(10),
    //     decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(8),
    //       border: Border.all(
    //         color: Colors.black,
    //         width: 1,
    //       )
    //     ),
    //     child: SvgPicture.asset(icon, height: 25, width: 25,),
    //   ),
    // );
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.bgWhite,
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(
          //   color: Colors.black,
          //   width: 0.5,
          // ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            SvgPicture.asset(icon, height: 25, width: 25),
            Text(title, style: const TextStyle(fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
