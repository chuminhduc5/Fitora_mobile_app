import 'package:fitora_mobile_app/core/config/assets/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CommentWidget extends StatelessWidget {
  final int? commentCount;
  final Function()? onPressed;

  const CommentWidget({super.key, this.commentCount, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 35,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 0),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SvgPicture.asset(AppSvg.comment, height: 20, width: 20),
            const SizedBox(width: 5),
            Text(commentCount.toString()),
          ],
        ),
      ),
    );
  }
}
