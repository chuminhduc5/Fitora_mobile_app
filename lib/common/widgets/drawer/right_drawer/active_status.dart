import 'package:flutter/material.dart';

Widget activeStatus(Color color, String status) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15),
    padding: const EdgeInsets.symmetric(vertical: 5),
    decoration: BoxDecoration(
      border: Border.all(color: color),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.circle, color: color, size: 18,),
        const SizedBox(width: 5,),
        Text('Trạng thái: ', style: TextStyle(color: color),),
        Text(status, style: TextStyle(color: color),),
      ],
    ),
  );
}
