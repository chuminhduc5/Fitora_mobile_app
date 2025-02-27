import 'package:flutter/material.dart';

class ButtonAuthWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final Color bgColor;

  const ButtonAuthWidget({
    super.key,
    required this.onPressed,
    required this.title,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
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
              borderRadius: BorderRadius.circular(5),
            )),
        child: Text(
          title,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}