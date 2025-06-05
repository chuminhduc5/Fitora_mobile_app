import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewWidget extends StatelessWidget {
  final ImageProvider imageProvider;

  const ImageViewWidget({super.key, required this.imageProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 30),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: PhotoView(
        imageProvider: imageProvider,
      ),
    );
  }
}
