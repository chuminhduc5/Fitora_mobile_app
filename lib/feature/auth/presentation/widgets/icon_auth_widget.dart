import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconAuthWidget extends StatelessWidget {
  final String icon;
  const IconAuthWidget({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white,
          width: 1,
        )
      ),
      child: SvgPicture.asset(icon, height: 25, width: 25,),
    );
  }
}
