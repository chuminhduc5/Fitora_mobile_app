import 'package:flutter/material.dart';

class VideoListWidget extends StatelessWidget {
  const VideoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          minHeight: 100,
        ),

    );
  }
}
