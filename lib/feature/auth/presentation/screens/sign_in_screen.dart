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

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  void _login(BuildContext context) {
    primaryFocus?.unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authForm = context.read<AuthSignInFormBloc>().state;
    final email = authForm.data.email;
    final password = authForm.data.password;
    logg.i("Email: $email");
    logg.i("Password: $password");

    context.read<AuthBloc>().add(
          AuthSignInEvent(
            params: AuthSignInFormData(
              email: email,
              password: password,
            ),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthSignInFormBloc>(),
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
                  IconAuthWidget(
                    onPressed: () {
                      return showAppDiaLodWidget(context);
                    },
                    title: "Đăng nhập với Apple",
                    icon: AppSvg.apple,
                  ),
                  const SizedBox(height: 15),
                  IconAuthWidget(
                    onPressed: () {
                      return showAppDiaLodWidget(context);
                    },
                    title: "Đăng nhập với Google",
                    icon: AppSvg.google,
                  ),
                  const SizedBox(height: 30),
                  const Row(
                    children: [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Hoặc'),
                      ),
                      Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 30),
                  AuthSignInInputWidget(formKey: _formKey),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: FCheckbox(
                          label: Text(
                            'Nhớ mật khẩu',
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      Text(
                        "Quên mật khẩu?",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.bgPink,
                          color: AppColors.bgPink,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 60,
              child: BlocConsumer<AuthBloc, AuthState>(
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
            ),
            const Positioned(
              right: 0,
              left: 0,
              bottom: 10,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Bằng cách đăng ký, bạn đồng ý với các điều khoản dịch vụ và chính sách bảo mật của chúng tôi!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
