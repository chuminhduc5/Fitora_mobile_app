import 'package:flutter/material.dart';

class UserVideoListWidget extends StatelessWidget {
  const UserVideoListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          minHeight: 100,
        ),
      ),
    );
  }
}
