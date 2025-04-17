import 'package:fitora_mobile_app/common/dialog/app_display_message.dart';
import 'package:fitora_mobile_app/common/loader/app_loading_widget.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/extensions/integer_sizebox_extension.dart';
import 'package:fitora_mobile_app/core/extensions/string_validator_extension.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/core/utils/logger_custom.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth_sign_in_form/auth_sign_in_form_bloc.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth_sign_up_form/auth_sign_up_form_bloc.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/forms/auth_sign_up_form_data.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/widgets/auth_sign_up_input_widget.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/widgets/button_auth_widget.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/widgets/password_condition_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forui/widgets/checkbox.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _signUp(BuildContext context) {
    primaryFocus?.unfocus();
    final authForm = context.read<AuthSignUpFormBloc>().state;
    logg.i("Username: ${authForm.data.username}");
    logg.i("Email: ${authForm.data.email}");
    logg.i("Password: ${authForm.data.password}");
    logg.i("ConfirmPassword: ${authForm.data.confirmPassword}");
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
      child: Container(
        color: AppColors.bgGrayLight,
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AuthSignUpInputWidget(),
                  BlocBuilder<AuthSignUpFormBloc, AuthSignUpFormState>(
                    builder: (context, state) {
                      final valid = state.data;
                      return Column(
                        children: [
                          PasswordConditionWidget(
                            title: 'Mật khẩu có ít nhất 6 ký tự',
                            condition: valid.password.hasMinLength,
                          ),
                          PasswordConditionWidget(
                            title: 'Mật khẩu có ít nhất 1 số',
                            condition: valid.password.hasNumber,
                          ),
                          PasswordConditionWidget(
                            title: 'Mật khẩu có cả chữ in hoa và in thường',
                            condition: valid.password.hasUpperAndLowerCase,
                          ),
                          PasswordConditionWidget(
                            title: 'Mật khẩu có ít nhất 1 ký tự đặc biệt',
                            condition: valid.password.hasSpecialChar,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            const Positioned(
              right: 0,
              left: 0,
              bottom: 75,
              child: FCheckbox(
                label: Text(
                  'Bạn xác nhận đồng ý với các điều khoản và điều kiện của chúng tôi. Vui lòng tích vào đây!',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 13),
                ),
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 20,
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (_, state) {
                  if (state is AuthSignUpSuccessState) {
                    AppDisplayMessage.success(context, 'Đăng ký thành công');
                    //context.goNamed(AppRoute.auth.name);
                  } else if (state is AuthSignUpFailureState) {
                    AppDisplayMessage.error(context, state.message);
                  }
                },
                builder: (context, state) {
                  if (state is AuthSignUpLoadingState) {
                    return const AppLoadingWidget();
                  }

                  return ButtonAuthWidget(
                    title: 'Đăng ký',
                    bgColor: AppColors.bgPink,
                    onPressed:
                        context.watch<AuthSignUpFormBloc>().state.data.isValid
                            ? () => _signUp(context)
                            : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
