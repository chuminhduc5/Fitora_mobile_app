import 'package:fitora_mobile_app/app/app_view.dart';
import 'package:fitora_mobile_app/common/helper/navigation/app_navigation.dart';
import 'package:fitora_mobile_app/core/config/assets/app_svg.dart';
import 'package:fitora_mobile_app/core/config/theme/app_colors.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/screens/register_screen.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/widgets/button_auth_widget.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/widgets/icon_auth_widget.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/widgets/text_field_auth_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_slash;
  bool isCheckAccountPassword = false;
  String fullName = '';
  int idEmp = 0;
  String username = '';
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
  
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        print("Logged in as: ${googleUser.displayName}");
        print("Email: ${googleUser.email}");
        print("Photo: ${googleUser.photoUrl}");
      } else {
        print("Sign-in aborted by user.");
      }
    } catch (error) {
      print("Error during Google sign-in: $error");
    }
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
                    Expanded(
                      child: SingleChildScrollView(
                        child: buildForm(),
                      ),
                    ),
                  ],
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                      child: TextFieldAuthWidget(
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
                      child: TextFieldAuthWidget(
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
                    const SizedBox(height: 15),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                          Text('Quên mật khẩu!', style: TextStyle(decoration: TextDecoration.underline),),
                      ],
                    ),
                    const SizedBox(height: 15),
                    ButtonAuthWidget(
                      title: 'Đăng nhập',
                      bgColor: Colors.orangeAccent,
                      onPressed: () {
                        AppNavigation.push(context, const AppView());
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
                        IconAuthWidget(onPressed: () {}, icon: AppSvg.facebookSvg),
                        const SizedBox(width: 25),
                        IconAuthWidget(onPressed: signInWithGoogle, icon: AppSvg.googleSvg),
                        const SizedBox(width: 25),
                        IconAuthWidget(onPressed: () {}, icon: AppSvg.appleWhiteSvg),
                      ],
                    ),
                  ],
                ),
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
                        AppNavigation.push(context, const RegisterScreen());
                      },
                      child: const Text(
                        'Đăng ký ngay!',
                        style: TextStyle(
                          color: Colors.white,
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
    );
  }
}
