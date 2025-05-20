import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String hinText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final String? initialValue;
  final void Function(String)? onChanged;
  final double? borderRadius;

  const AppTextFieldWidget({
    super.key,
    this.controller,
    required this.hinText,
    required this.obscureText,
    required this.keyboardType,
    this.textInputAction,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.initialValue,
    this.onChanged,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onChanged: onChanged,
      textInputAction: TextInputAction.next,
      autovalidateMode: autovalidateMode,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: const BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius!),
          borderSide: const BorderSide(color: AppColors.pink, width: 1),
        ),
        fillColor: Colors.white,
        filled: true,
        hintText: hinText,
        hintStyle: TextStyle(color: Colors.grey[500]),
      ),
      onTapOutside: (events) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}
