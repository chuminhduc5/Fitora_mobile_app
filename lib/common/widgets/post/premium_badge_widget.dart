import 'package:flutter/material.dart';

class PremiumBadgeWidget extends StatelessWidget {
  const PremiumBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        onPressed: () {},
        //icon: const Icon(Icons.workspace_premium, size: 20),
        icon: const Icon(Icons.bookmarks_outlined, size: 20),
      ),
    );
  }
}
