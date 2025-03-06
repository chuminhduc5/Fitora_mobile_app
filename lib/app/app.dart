import 'package:fitora_mobile_app/core/blocs/theme/theme_bloc.dart';
import 'package:fitora_mobile_app/core/blocs/translate/translate_bloc.dart';
import 'package:fitora_mobile_app/core/config/theme/app_theme.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_conf.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:fitora_mobile_app/feature/home/presentation/blocs/newsfeed/newsfeed_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/post/post_bloc.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/blocs/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = getIt<AppRouteConf>().router;
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) =>
          GestureDetector(
            onTap: () => primaryFocus?.unfocus(),
            child: MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => getIt<ThemeBloc>()),
                BlocProvider(create: (_) => getIt<TranslateBloc>()),
                BlocProvider(
                  create: (_) =>
                  getIt<AuthBloc>()
                    ..add(AuthCheckSignInStatusEvent()),
                ),
                BlocProvider(create: (_) => getIt<NewsfeedBloc>()),
                BlocProvider(create: (_) => getIt<PostBloc>()),
                BlocProvider(create: (_) => getIt<ProfileBloc>()),
              ],
              child: BlocListener<AuthBloc, AuthState>(
                listenWhen: (_, current) =>
                current is AuthCheckSignInStatusLoadingState,
                listener: (_, state) {
                  if (state is AuthCheckSignInStatusSuccessState) {
                    // final user = state.data;
                    router.goNamed('app-view');
                  }
                },
                child: BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    return MaterialApp.router(
                      debugShowCheckedModeBanner: false,
                      routerConfig: router,
                      theme: AppTheme.lightMode,
                    );
                  },
                ),
              ),
            ),
          ),
    );
  }
}
