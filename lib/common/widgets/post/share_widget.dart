import 'package:fitora_mobile_app/core/config/assets/app_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShareWidget extends StatelessWidget {
  final int? shareCount;

  const ShareWidget({super.key, this.shareCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                AppSvg.share,
                height: 20,
                width: 20,
                color: Colors.black,
              )),
          Text(shareCount.toString()),
        ],
      ),
    );
  }
}
