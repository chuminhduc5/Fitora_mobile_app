import 'package:flutter/material.dart';

Widget buttonAuthWidget(BuildContext context, {Function()? onPressed, required String title, required Color bgColor}) {
  return Container(
    height: 45,
    width: MediaQuery.of(context).size.width,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: bgColor,
          padding: const EdgeInsets.all(5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      child: Text(title, style: const TextStyle(fontSize: 20)),
    ),
  );
}