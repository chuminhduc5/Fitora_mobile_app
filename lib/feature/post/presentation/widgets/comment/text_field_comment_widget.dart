import 'package:flutter/material.dart';

class TextFieldCommentWidget extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;

  const TextFieldCommentWidget({
    super.key,
    required this.controller,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: "Viết bình luận...",
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      textInputAction: TextInputAction.send,
      onSubmitted: (text) {
        print('Gửi bình luận: $text');
        controller.clear();
      },
    );
  }
}
