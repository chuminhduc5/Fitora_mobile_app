import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:flutter/material.dart';

class ButtonAuthWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final Color bgColor;
  final bool isLoading;

  const ButtonAuthWidget({
    super.key,
    required this.onPressed,
    required this.title,
    required this.bgColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
        child: isLoading
            ? const AppLoadingWidget()
            : Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
      ),
    );
  }
}
