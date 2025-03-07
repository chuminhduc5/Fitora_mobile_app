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
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: 250, width: 250,
                      child: Image.asset(AppImages.logoLogin, fit: BoxFit.cover,),
                    ),
                  ),
                  20.hS,
                  const Text(
                    'Chào mừng trở lại!',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                  const Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 12, 0, 24),
                    child: Text(
                      'Xin hãy đăng nhập vào tài khoản của bạn',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const AuthSignInInputWidget(),
                  20.hS,
                  BlocConsumer<AuthBloc, AuthState>(
                    listener: (_, state) {
                      if (state is AuthSignInFailureState) {
                        AppDisplayMessage.error(context, state.message);
                      } else if (state is AuthSignInSuccessState) {
                        //final user = state.data;
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconAuthWidget(
                          onPressed: () {}, icon: AppSvg.facebookSvg),
                      const SizedBox(width: 25),
                      IconAuthWidget(onPressed: () {}, icon: AppSvg.googleSvg),
                      const SizedBox(width: 25),
                      IconAuthWidget(onPressed: () {}, icon: AppSvg.appleSvg),
                    ],
                  ),
                  const SizedBox(height: 25),
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
