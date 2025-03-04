import 'package:fitora_mobile_app/core/config/theme/app_theme.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:fitora_mobile_app/feature/home/presentation/blocs/newsfeed/newsfeed_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/post/post_bloc.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/blocs/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../core/blocs/theme/theme_bloc.dart';
import '../core/blocs/translate/translate_bloc.dart';
import '../core/di/injection.dart';
import '../core/navigation/router/app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => GestureDetector(
        onTap: () => primaryFocus?.unfocus(),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<ThemeBloc>()),
            BlocProvider(create: (_) => getIt<TranslateBloc>()),
            BlocProvider(
              create: (_) =>
                  getIt<AuthBloc>()..add(AuthCheckSignInStatusEvent()),
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
                appRouter.goNamed('app-view');
              }
            },
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: appRouter,
              theme: AppTheme.lightMode,
            ),
          ),
        ),
      ),
    );
  }
}
