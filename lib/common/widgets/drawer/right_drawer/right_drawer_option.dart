import 'package:flutter/material.dart';

Widget rightDrawerOption(IconData icon, String title, String? description) {
  return ListTile(
    contentPadding: const EdgeInsets.all(0),
    dense: true,
    leading: Icon(icon, size: 20,),
    title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),),
    subtitle: description != null
        ? Text(description, style: const TextStyle(fontSize: 13),)
        : null,
  );
}