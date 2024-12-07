import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/widgets/button_auth_widget.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/widgets/text_field_auth_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_slash;
  bool isCheckAccountPassword = false;
  String fullName = '';
  int idEmp = 0;
  String username = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxScreenHeight = MediaQuery.of(context).size.height;
    final maxScreenWidth = MediaQuery.of(context).size.width;
    final isLandscape = maxScreenWidth > maxScreenHeight;

    return Scaffold(
      backgroundColor: ThemeData.dark().scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          child: isLandscape
              ? Row(
                  children: [
                    // Expanded(
                    //   child: Container(
                    //     padding: EdgeInsets.only(top: maxScreenHeight * 0.1),
                    //     child: Image.asset(
                    //       'assets/images/hacom-logo.png',
                    //       width: 400,
                    //       height: 400,
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: buildForm(),
                      ),
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // Container(
                      //   child: Image.asset(
                      //     'assets/images/hacom-logo.png',
                      //     width: 250,
                      //     height: 250,
                      //   ),
                      // ),
                      buildForm(),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget buildForm() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Container(
        width: double.infinity,
        constraints: const BoxConstraints(
          maxWidth: 600,
        ),
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
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: textFieldAuthWidget(
                        controller: _usernameController,
                        hinText: 'Tài khoản',
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(CupertinoIcons.person),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Vui lòng nhập tài khoản";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 25),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: textFieldAuthWidget(
                        controller: _passwordController,
                        hinText: 'Mật khẩu',
                        obscureText: obscurePassword,
                        keyboardType: TextInputType.visiblePassword,
                        prefixIcon: const Icon(CupertinoIcons.lock),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Vui lòng nhập mật khẩu';
                          }
                          return null;
                        },
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscurePassword = !obscurePassword;
                              iconPassword = obscurePassword
                                  ? CupertinoIcons.eye_slash
                                  : CupertinoIcons.eye;
                            });
                          },
                          icon: Icon(iconPassword),
                        ),
                      ),
                    ),
                    if (isCheckAccountPassword) ...[
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        'Tài khoản hoặc mật khẩu của bạn chưa chính xác!',
                        style: TextStyle(color: AppColors.textRed),
                      ),
                    ],
                    const SizedBox(height: 25),
                    buttonAuthWidget(
                      context,
                      title: 'Đăng nhập',
                      bgColor: Colors.orangeAccent,
                      onPressed: () {},
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

                    // Social login buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.facebook,
                            color: Colors.blue,
                            size: 30,
                          ),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          icon: const Icon(
                            Icons.mail,
                            color: Colors.red,
                            size: 30,
                          ),
                          onPressed: () {},
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          icon: const Icon(
                            Icons.apple,
                            color: Colors.black,
                            size: 30,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
