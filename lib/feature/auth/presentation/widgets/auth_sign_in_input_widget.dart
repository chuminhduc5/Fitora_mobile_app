import 'package:easy_localization/easy_localization.dart';
import 'package:fitora_mobile_app/core/config/assets/app_svg.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth_sign_in_form/auth_sign_in_form_bloc.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/widgets/auth_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthSignInInputWidget extends StatelessWidget {
  const AuthSignInInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthSignInFormBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Email", style: TextStyle(fontSize: 14)),
        AuthTextFieldWidget<AuthSignInFormBloc>(
          label: "Email".tr(),
          hintText: "yourname@gmail.com",
          prefixIcon: Icon(Icons.email, size: 18),
          //prefixIcon: SvgPicture(AppSvg),
          onChanged: (val) {
            authBloc.add(AuthSignInFormEmailChangedEvent(val));
          },
        ),
        const Text("Mật khẩu", style: TextStyle(fontSize: 14)),
        AuthTextFieldWidget<AuthSignInFormBloc>(
          label: "Password".tr(),
          hintText: "********",
          prefixIcon: Icon(Icons.lock, size: 18,),
          onChanged: (val) {
            authBloc.add(AuthSignInFormPasswordChangedEvent(val));
          },
          isSecure: true,
        ),
      ],
    );
  }
}
