import 'package:flutter/material.dart';

Widget leftDrawerOption(String? avatar, IconData? icon, String title, Function()? onPressed) {
  return ListTile(
    contentPadding: const EdgeInsets.only(left: 15),
    dense: true,
    leading: ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.asset(avatar!, height: 25, width: 25, fit: BoxFit.cover,),
    ),
    title: Text(title, style: const TextStyle(fontSize: 14),),
    trailing: IconButton(onPressed: (){}, icon: Icon(icon, size: 20,),),
    onTap: onPressed,
  );
}