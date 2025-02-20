import 'package:easy_localization/easy_localization.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth_sign_in_form/auth_sign_in_form_bloc.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/widgets/auth_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthSignInInputWidget extends StatelessWidget {
  const AuthSignInInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthSignInFormBloc>();
    return Column(
      children: [
        AuthTextFieldWidget<AuthSignInFormBloc>(
          label: "Email".tr(),
          onChanged: (val) {
            authBloc.add(AuthSignInFormEmailChangedEvent(val));
          },
        ),
        AuthTextFieldWidget<AuthSignInFormBloc>(
          label: "Password".tr(),
          onChanged: (val) {
            authBloc.add(AuthSignInFormPasswordChangedEvent(val));
          },
          isSecure: true,
        ),
      ],
    );
  }
}
