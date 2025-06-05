import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:flutter/material.dart';

class FriendCardWidget extends StatelessWidget {
  final String? imagePath;

  const FriendCardWidget({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    ImageProvider? imageProvider;

    bool _isValidNetwork(String? path) =>
        path != null && path.trim().isNotEmpty && path.startsWith('https');

    bool _isValidFile(String? path) =>
        path != null && path.trim().isNotEmpty && File(path).existsSync();

    if (_isValidNetwork(imagePath)) {
      imageProvider = NetworkImage(imagePath!);
    } else if (_isValidFile(imagePath)) {
      imageProvider = FileImage(File(imagePath!));
    }

    if (imageProvider != null) {
      return CachedNetworkImage(
        imageUrl: imagePath!,
        placeholder: (context, url) => const SizedBox(
          width: 115,
          height: 115,
          child: AppLoadingWidget(),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        width: 115,
        height: 115,
        fit: BoxFit.cover,
      );
    } else {
      return const SizedBox();
    }
  }
}
