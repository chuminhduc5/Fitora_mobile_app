import 'package:flutter/material.dart';

class UserPostListWidget extends StatelessWidget {
  const UserPostListWidget({super.key});

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
