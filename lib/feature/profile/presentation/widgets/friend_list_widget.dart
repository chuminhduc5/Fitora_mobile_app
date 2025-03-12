import 'package:flutter/material.dart';

class FriendListWidget extends StatelessWidget {
  const FriendListWidget({super.key});

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
