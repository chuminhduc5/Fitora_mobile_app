import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/core/extensions/integer_sizebox_extension.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth_sign_up_form/auth_sign_up_form_bloc.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/forms/auth_sign_up_form_data.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/widgets/auth_sign_up_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/config/theme/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../../../common/dialog/app_display_message.dart';
import '../../../../core/navigation/router/app_router.dart';
import '../blocs/auth/auth_bloc.dart';
import '../widgets/button_auth_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _signUp(BuildContext context) {
    primaryFocus?.unfocus();
    final authForm = context.read<AuthSignUpFormBloc>().state;
    context.read<AuthBloc>().add(
          AuthSignUpEvent(
            params: AuthSignUpFormData(
              username: authForm.data.username,
              email: authForm.data.email,
              password: authForm.data.password,
              confirmPassword: authForm.data.confirmPassword,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthSignUpFormBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.bgWhite,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    const AuthSignUpInputWidget(),
                    20.hS,
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (_, state) {
                        if (state is AuthSignUpSuccessState) {
                          AppDisplayMessage.success(context, 'Đăng ký thành công');
                          appRouter.go('/sign-in');
                        } else if (state is AuthSignUpFailureState) {
                          AppDisplayMessage.error(context, 'Đăng ký thất bại');
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthSignUpLoadingState) {
                          return const AppLoadingWidget();
                        }

                        return ButtonAuthWidget(
                          title: 'Đăng ký',
                          bgColor: AppColors.bgPink,
                          onPressed: () {
                            _signUp(context);
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 25),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Bạn đã có tài khoản!',
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Đăng nhập ngay!',
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
          ],),
        ),

    );
  }
}
