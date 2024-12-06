import 'package:flutter/material.dart';

Widget leftDrawerOption(IconData? icon, String title, Function()? onPressed) {
  return ListTile(
    contentPadding: const EdgeInsets.only(left: 15),
    leading: const CircleAvatar(
      radius: 12,
      child: Text('H', style: TextStyle(fontSize: 13),),
    ),
    title: Text(title, style: const TextStyle(fontSize: 14),),
    trailing: IconButton(onPressed: (){}, icon: Icon(icon, size: 20,),),
    onTap: onPressed,
  );
}