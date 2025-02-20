import 'package:easy_localization/easy_localization.dart';
import 'package:fitora_mobile_app/core/extensions/string_validator_extension.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth_sign_up_form/auth_sign_up_form_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/config/theme/app_colors.dart';

class AuthTextFieldWidget<T> extends StatefulWidget {
  final String label;
  final bool? isSecure;
  final List<TextInputFormatter>? inputFormat;
  final void Function(String)? onChanged;
  final String? initialValue;

  const AuthTextFieldWidget({
    super.key,
    required this.label,
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
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: TextFormField(
        initialValue: widget.initialValue,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: widget.isSecure ?? false ? _isVisible : false,
        cursorColor: Colors.purple,
        onChanged: widget.onChanged,
        inputFormatters: widget.inputFormat,
        validator: (val) {
          if (formBloc is AuthSignUpFormBloc) {
            if (widget.label == "input_nama_pengguna".tr() && val == "") {
              return "Username tidak boleh kosong";
            } else if (widget.label == "input_email".tr() &&
                !formBloc.state.data.email.isEmailValid) {
              return "Email tidak valid";
            } else if ((widget.label == "input_kata_sandi".tr() ||
                    widget.label == "input_konfirmasi_kata_sandi".tr()) &&
                val!.length < 6) {
              return "Password minimal 6 karakter";
            } else if (widget.label == "input_kata_sandi".tr() &&
                !formBloc.state.data.password.isPasswordValid) {
              return "Password harus kombinasi huruf dan angka";
            } else if (widget.label == "input_konfirmasi_kata_sandi".tr() &&
                !formBloc.state.data.confirmPassword.isPasswordValid) {
              return "Password harus kombinasi huruf dan angka";
            } else if (widget.label == "input_konfirmasi_kata_sandi".tr() &&
                formBloc.state.data.password !=
                    formBloc.state.data.confirmPassword) {
              return "Password tidak sama";
            }
          }
          return null;
        },
        decoration: InputDecoration(
          label: Text(widget.label),
          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          suffixIcon: widget.isSecure ?? false
              ? IconButton(
                  onPressed: () {
                    _toggleVisibility();
                  },
                  icon: Icon(
                    _isVisible
                        ? Icons.visibility_rounded
                        : Icons.visibility_off_rounded,
                  ),
                  splashRadius: 20.r,
                )
              : null,
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide:
            const BorderSide(color: AppColors.pink, width: 1),
          ),
        ),
      ),
    );
  }
}
