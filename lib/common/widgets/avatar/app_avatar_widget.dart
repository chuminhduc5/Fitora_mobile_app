import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forui/forui.dart';

class AppAvatarWidget extends StatelessWidget {
  final String? imagePath;
  final double size;
  final String fallbackText;
  final String fallbackSvgAsset;

  const AppAvatarWidget({
    super.key,
    required this.imagePath,
    required this.size,
    this.fallbackText = '',
    this.fallbackSvgAsset = 'assets/svg/person.svg',
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
      return FAvatar(
        image: imageProvider,
        fallback: Text(fallbackText),
        size: size,
      );
    } else {
      return FAvatar(image: const NetworkImage(""), size: size);
    }
  }
}
