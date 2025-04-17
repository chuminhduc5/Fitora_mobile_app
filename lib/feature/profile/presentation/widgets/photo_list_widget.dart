import 'package:flutter/material.dart';

class PhotoListWidget extends StatelessWidget {
  const PhotoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(
        minHeight: 100,
      ),
      child: _buildLayoutImage(),
    );
  }

  Widget _buildLayoutImage() {
    final List<String> imageUrls = [
      'https://i.imgur.com/5M37i3l.jpg',
      'https://i.imgur.com/5M37i3l.jpg',
      'https://i.imgur.com/5M37i3l.jpg',
      'https://i.imgur.com/5M37i3l.jpg',
      'https://i.imgur.com/5M37i3l.jpg',
      'https://i.imgur.com/5M37i3l.jpg',
      'https://i.imgur.com/5M37i3l.jpg',
      'https://i.imgur.com/5M37i3l.jpg',
      'https://i.imgur.com/5M37i3l.jpg',
    ];

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: imageUrls.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrls[index],
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.image, size: 16, color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }
}
