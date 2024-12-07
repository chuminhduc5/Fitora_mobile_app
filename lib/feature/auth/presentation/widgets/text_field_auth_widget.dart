import 'package:flutter/material.dart';

Widget textFieldAuthWidget({
  required TextEditingController controller,
  required String hinText,
  required bool obscureText,
  required TextInputType keyboardType,
  Widget? suffixIcon,
  Widget? prefixIcon,
  String? Function(String?)? validator,
  required AutovalidateMode autovalidateMode,
}) {
  return TextFormField(
    validator: validator,
    controller: controller,
    obscureText: obscureText,
    keyboardType: keyboardType,
    textInputAction: TextInputAction.next,
    autovalidateMode: autovalidateMode,
    decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.grey[100]!,
          width: 0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        // borderSide:
        // const BorderSide(color: AppColors.bgOutlineFieldFocus, width: 1),
      ),
      fillColor: Colors.grey[100],
      filled: true,
      hintText: hinText,
      hintStyle: TextStyle(color: Colors.grey[500]),
    ),
    onTapOutside: (events) {
      FocusManager.instance.primaryFocus?.unfocus();
    },
  );
}
