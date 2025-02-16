import 'package:flutter/material.dart';

Widget styleAvatar() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          //color: Colors.grey[850],
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.style),
            SizedBox(width: 5,),
            Text('Thay đổi')
          ],
        ),
      ),
    ],
  );
}