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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Họ tên", style: TextStyle(fontSize: 14)),
        AuthTextFieldWidget<AuthSignUpFormBloc>(
          label: "Username".tr(),
          hintText: "Họ và tên",
          prefixIcon: Icon(Icons.person, size: 18,),
          onChanged: (val) {
            authBloc.add(SignUpFormUsernameChangedEvent(val));
          },
        ),
        const Text("Email", style: TextStyle(fontSize: 14)),
        AuthTextFieldWidget<AuthSignUpFormBloc>(
          label: "Email".tr(),
          prefixIcon: Icon(Icons.email, size: 18),
          hintText: "yourname@gmail.com",
          onChanged: (val) {
            authBloc.add(SignUpFormEmailChangedEvent(val));
          },
        ),
        const Text("Mật khẩu", style: TextStyle(fontSize: 14)),
        AuthTextFieldWidget<AuthSignUpFormBloc>(
          label: "Password".tr(),
          hintText: "********",
          prefixIcon: Icon(Icons.lock, size: 18,),
          onChanged: (val) {
            authBloc.add(SignUpFormPasswordChangedEvent(val));
          },
          isSecure: true,
        ),
        // AuthTextFieldWidget<AuthSignUpFormBloc>(
        //   label: "Confirm password",
        //   hintText: "",
        //   onChanged: (val) {
        //     authBloc.add(SignUpFormConfirmPasswordChangedEvent(val));
        //   },
        //   isSecure: true,
        // ),
      ],
    );
  }
}
