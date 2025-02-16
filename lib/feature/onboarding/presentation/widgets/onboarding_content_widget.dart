import 'package:fitora_mobile_app/feature/onboarding/presentation/widgets/onboard_title_description_widget.dart';
import 'package:flutter/material.dart';

class OnboardingContentWidget extends StatelessWidget {
  final String title;
  final String image;
  final String description;
  final bool isTextOnTop;

  const OnboardingContentWidget({
    super.key,
    required this.title,
    required this.image,
    required this.description,
    this.isTextOnTop = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        if (isTextOnTop)
          OnboardTitleDescriptionWidget(
            title: title,
            description: description,
          ),
        if (isTextOnTop) const Spacer(),

        Image.asset(image, height: 250),

        if (!isTextOnTop) const Spacer(),
        if (!isTextOnTop)
          const OnboardTitleDescriptionWidget(
            title: "",
            description: "",
          ),

        const Spacer(),
      ],
    );
  }
}
