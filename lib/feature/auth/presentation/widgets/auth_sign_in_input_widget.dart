import 'package:easy_localization/easy_localization.dart';
import 'package:fitora_mobile_app/core/config/assets/app_svg.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth_sign_in_form/auth_sign_in_form_bloc.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/widgets/auth_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthSignInInputWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const AuthSignInInputWidget({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthSignInFormBloc>();
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthTextFieldWidget<AuthSignInFormBloc>(
            label: "Email".tr(),
            hintText: "Nhập email của bạn",
            prefixIcon: const Icon(Icons.email_outlined, size: 18),
            onChanged: (val) {
              authBloc.add(AuthSignInFormEmailChangedEvent(val));
            },
          ),
          AuthTextFieldWidget<AuthSignInFormBloc>(
            label: "Password".tr(),
            hintText: "Nhập mật khẩu của bạn",
            prefixIcon: const Icon(Icons.lock_outline, size: 18,),
            onChanged: (val) {
              authBloc.add(AuthSignInFormPasswordChangedEvent(val));
            },
            isSecure: true,
          ),
        ],
      ),
    );
  }
}
