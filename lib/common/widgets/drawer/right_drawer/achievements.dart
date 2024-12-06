import 'package:flutter/material.dart';

Widget achievements() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.grey[850],
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: const Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.yellow,
                radius: 16.0,
                child: Icon(Icons.star, color: Colors.white, size: 16.0),
              ),
              Positioned(
                left: 15,
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 16.0,
                  child: Icon(Icons.star, color: Colors.white, size: 16.0),
                ),
              ),
              Positioned(
                left: 30,
                child: CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: 16.0,
                  child: Icon(Icons.star, color: Colors.white, size: 16.0),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "5 Achievements",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
            Text(
              "View details",
              style: TextStyle(color: Colors.grey, fontSize: 12.0),
            ),
          ],
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16.0),
      ],
    ),
  );
}
