import 'package:easy_localization/easy_localization.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth_sign_up_form/auth_sign_up_form_bloc.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/widgets/auth_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthSignUpInputWidget extends StatelessWidget {
  const AuthSignUpInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthSignUpFormBloc>();
    return Column(
      children: [
        AuthTextFieldWidget<AuthSignUpFormBloc>(
          label: "Username".tr(),
          onChanged: (val) {
            authBloc.add(SignUpFormUsernameChangedEvent(val));
          },
        ),
        AuthTextFieldWidget<AuthSignUpFormBloc>(
          label: "Email".tr(),
          onChanged: (val) {
            authBloc.add(SignUpFormEmailChangedEvent(val));
          },
        ),
        AuthTextFieldWidget<AuthSignUpFormBloc>(
          label: "Password".tr(),
          onChanged: (val) {
            authBloc.add(SignUpFormPasswordChangedEvent(val));
          },
          isSecure: true,
        ),
        AuthTextFieldWidget<AuthSignUpFormBloc>(
          label: "Confirm password",
          onChanged: (val) {
            authBloc.add(SignUpFormConfirmPasswordChangedEvent(val));
          },
          isSecure: true,
        ),
      ],
    );
  }
}
