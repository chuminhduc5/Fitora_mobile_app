import 'package:flutter/material.dart';
import 'package:forui/forui.dart';

showAppDiaLodWidget(BuildContext context) {
  return showAdaptiveDialog(
    context: context,
    builder: (context) => FDialog(
      direction: Axis.horizontal,
      title: const Text('Tính năng đang phát triển'),
      actions: [
        FButton(label: const Text('Đóng'), onPress: () => Navigator.of(context).pop()),
      ],
    ),
  );
}