import 'package:easy_localization/easy_localization.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfileTextFieldWidget extends StatelessWidget {
  final String label;
  final String hintText;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormat;
  final TextInputType? inputType;
  final void Function(String)? onChanged;
  final String? initialValue;
  const ProfileTextFieldWidget({super.key,
    required this.label,
    required this.hintText,
    this.prefixIcon,
    this.inputFormat,
    this.inputType,
    required this.onChanged,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        initialValue: initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        onChanged: onChanged,
        inputFormatters: inputFormat,
        keyboardType: inputType,
        validator: (val) {
          if (label == "Tên".tr() && val == null) {
            return "Tên không được để trống!";
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          prefixIcon: prefixIcon,
          prefixStyle: const TextStyle(color: Colors.black),
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.pink, width: 1),
          ),
          errorStyle: const TextStyle(
            color: Colors.red,
            fontSize: 13,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.pink,
              width: 0.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.pink, width: 1),
          ),
        ),
      ),
    );
  }
}
