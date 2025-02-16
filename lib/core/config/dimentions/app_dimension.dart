import 'package:flutter/material.dart';

class AppDimensions {
  // Padding
  static const EdgeInsets paddingSmall = EdgeInsets.all(8.0);
  static const EdgeInsets paddingMedium = EdgeInsets.all(16.0);
  static const EdgeInsets paddingLarge = EdgeInsets.all(24.0);

  // Margin
  static const EdgeInsets marginSmall = EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0);
  static const EdgeInsets marginMedium = EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0);
  static const EdgeInsets marginLarge = EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0);

  // Border radius
  static const double borderRadiusSmall = 8.0;
  static const double borderRadiusMedium = 16.0;
  static const double borderRadiusLarge = 24.0;

  // Border
  static const BorderSide defaultBorder = BorderSide(color: Colors.grey, width: 1.0);

  static final BoxDecoration defaultBoxDecoration = BoxDecoration(
    border: Border.all(color: Colors.grey, width: 1.0),
    borderRadius: BorderRadius.circular(AppDimensions.borderRadiusMedium),
  );
}
