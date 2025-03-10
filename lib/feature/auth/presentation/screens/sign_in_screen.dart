import 'package:fitora_mobile_app/common/dialog/app_dialog_widget.dart';
import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/core/config/assets/app_images.dart';
import 'package:fitora_mobile_app/core/config/assets/app_svg.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/extensions/integer_sizebox_extension.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth_sign_in_form/auth_sign_in_form_bloc.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/forms/auth_sign_in_form_data.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/widgets/auth_sign_in_input_widget.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/widgets/button_auth_widget.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/widgets/icon_auth_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/forui.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  void _login(BuildContext context) {
    primaryFocus?.unfocus();
    final authForm = context.read<AuthSignInFormBloc>().state;
    context.read<AuthBloc>().add(
          AuthSignInEvent(
            params: AuthSignInFormData(
              email: authForm.data.email,
              password: authForm.data.password,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthSignInFormBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.bgWhite,
        resizeToAvoidBottomInset: false,
        body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Fitora",
                    style: TextStyle(
                        color: AppColors.bgPink,
                        fontSize: 40,
                        fontWeight: FontWeight.w700),
                  ),
                  10.hS,
                  const Text(
                    'Chào mừng bạn!',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 15),
                    child: Text(
                      'Xin hãy đăng nhập vào tài khoản của bạn',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const AuthSignInInputWidget(),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FCheckbox(
                          label: Text(
                            'Nhớ mật khẩu',
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                          // value: state,
                          // onChange: (value) => setState(() => state = value),
                        ),
                      ),
                      Text(
                        "Quên mật khẩu",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.bgPink,
                          color: AppColors.bgPink,
                        ),
                      ),
                    ],
                  ),
                  20.hS,
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (_, state) {
                      if (state is AuthSignInFailureState) {
                        AppDisplayMessage.error(context, state.message);
                      } else if (state is AuthSignInSuccessState) {
                        context.goNamed(AppRoute.appView.name);
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthSignInLoadingState) {
                        return const AppLoadingWidget();
                      }
                      return ButtonAuthWidget(
                        title: 'Đăng nhập',
                        bgColor: AppColors.bgPink,
                        onPressed: () {
                          _login(context);
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Or'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  IconAuthWidget(
                    onPressed: () {
                      logg.i("---OnClick---");
                      return showAppDiaLodWidget(context);
                    },
                    title: "Đăng nhập với Google",
                    icon: AppSvg.googleSvg,
                  ),
                  const SizedBox(height: 30),
                  //const Spacer(),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Bạn chưa có tài khoản?',
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        TextButton(
                          onPressed: () {
                            context.pushReplacementNamed(AppRoute.signUp.name);
                            logg.i('OnClick');
                          },
                          child: const Text(
                            'Đăng ký ngay!',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
