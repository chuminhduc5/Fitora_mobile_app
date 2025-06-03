import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class GroupBackgroundWidget extends StatelessWidget {
  final String? imagePath;
  //final double size;

  const GroupBackgroundWidget({
    super.key,
    required this.imagePath,
    //required this.size,
  });

  bool _isValidNetwork(String? path) =>
      path != null && path.trim().isNotEmpty && path.startsWith('https');

  bool _isValidFile(String? path) =>
      path != null &&
          path.trim().isNotEmpty &&
          (path.startsWith('/data') || path.startsWith('/storage'));

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;

    if (_isValidNetwork(imagePath)) {
      imageProvider = NetworkImage(imagePath!);
    } else if (_isValidFile(imagePath)) {
      imageProvider = FileImage(File(imagePath!));
    }

    if (imageProvider != null) {
      return Container(
        width: double.infinity,
        height: 220,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        height: 220,
        color: AppColors.bgGray,
      );
    }
  }
}
