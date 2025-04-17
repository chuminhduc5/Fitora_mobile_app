import 'package:easy_localization/easy_localization.dart';
import 'package:fitora_mobile_app/core/extensions/string_validator_extension.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth_sign_in_form/auth_sign_in_form_bloc.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth_sign_up_form/auth_sign_up_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/theme/app_colors.dart';

class AuthTextFieldWidget<T> extends StatefulWidget {
  final String label;
  final String hintText;
  final Widget? prefixIcon;
  final bool? isSecure;
  final List<TextInputFormatter>? inputFormat;
  final void Function(String)? onChanged;
  final String? initialValue;

  const AuthTextFieldWidget({
    super.key,
    required this.label,
    required this.hintText,
    this.prefixIcon,
    this.isSecure,
    this.inputFormat,
    required this.onChanged,
    this.initialValue,
  });

  @override
  State<AuthTextFieldWidget<T>> createState() => _AuthTextFieldWidgetState<T>();
}

class _AuthTextFieldWidgetState<T> extends State<AuthTextFieldWidget<T>> {
  bool _isVisible = true;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final formBloc = context.read<T>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        initialValue: widget.initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: widget.isSecure ?? false ? _isVisible : false,
        cursorColor: Colors.purple,
        onChanged: widget.onChanged,
        inputFormatters: widget.inputFormat,
        validator: (val) {
          if (formBloc is AuthSignInFormBloc) {
            if (widget.label == "Email" && val == "") {
              return "Email không được để trống";
            } else if (widget.label == "Password" && val == "") {
              return "Mật khẩu không được để trống";
            }
          }

          if (formBloc is AuthSignUpFormBloc) {
            if (widget.label == "Username".tr() && val == "") {
              return "Tên người dùng không được xác định";
            } else if (widget.label == "Email".tr() &&
                !formBloc.state.data.email.isEmailValid) {
              return "Email không hợp lệ";
            } else if ((widget.label == "Password".tr() ||
                    widget.label == "Confirm Password".tr()) &&
                val!.length < 6) {
              return "Mật khẩu tối thiểu 6 ký tự";
            } else if (widget.label == "Password".tr() &&
                !formBloc.state.data.password.isPasswordValid) {
              return "Mật khẩu yếu, vui lòng đặt lại!";
            } else if (widget.label == "Confirm Password".tr() &&
                !formBloc.state.data.confirmPassword.isPasswordValid) {
              return "Mật khẩu yếu, vui lòng đặt lại!";
            } else if (widget.label == "Confirm Password".tr() &&
                formBloc.state.data.password !=
                    formBloc.state.data.confirmPassword) {
              return "Mật khẩu chưa khớp, vui lòng nhập lại mật khẩu!";
            }
          }
          return null;
        },
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(fontSize: 14),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          prefixIcon: widget.prefixIcon,
          prefixStyle: const TextStyle(color: Colors.black),
          suffixIcon: widget.isSecure ?? false
              ? IconButton(
                  onPressed: () {
                    _toggleVisibility();
                  },
                  icon: IconTheme(
                    data: const IconThemeData(color: Colors.black),
                    child: Icon(
                      _isVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                  splashRadius: 20.r,
                )
              : null,
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: AppColors.bgGrayLight,
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
