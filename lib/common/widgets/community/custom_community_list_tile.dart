import 'package:flutter/material.dart';

class CustomCommunityListTile extends StatelessWidget {
  const CustomCommunityListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: 15),
      leading: const CircleAvatar(
        radius: 12,
        child: Text('H', style: TextStyle(fontSize: 13),),
      ),
      title: const Text('Tất cả', style: TextStyle(fontSize: 14),),
      trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.star_border, size: 20,),),
      onTap: () {},
    );
  }
}
