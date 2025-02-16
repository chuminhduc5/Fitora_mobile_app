import 'package:fitora_mobile_app/app/app_view.dart';
import 'package:fitora_mobile_app/core/config/router/app_router.dart';
import 'package:fitora_mobile_app/core/config/theme/app_theme.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme.lightMode,
    );
  }
}
