import 'package:flutter/material.dart';

class OnboardTitleDescriptionWidget extends StatelessWidget {
  final String title;
  final String description;

  const OnboardTitleDescriptionWidget({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 16),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
