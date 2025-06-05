import 'package:fitora_mobile_app/core/blocs/theme/theme_bloc.dart';
import 'package:fitora_mobile_app/core/blocs/translate/translate_bloc.dart';
import 'package:fitora_mobile_app/core/config/theme/app_theme.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_conf.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_path.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/comment/comment_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/interact/interact_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/newsfeed/newsfeed_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/post/post_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/post_form/post_form_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/upload_file/upload_file_bloc.dart';
import 'package:fitora_mobile_app/feature/search/presentation/blocs/search_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/friend/friend_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/group/group_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/personal/personal_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/profile/profile_bloc.dart';
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
            BlocProvider(create: (_) => getIt<PostFormBloc>()),
            //BlocProvider(create: (_) => getIt<SavedPostBloc>()),
            BlocProvider(create: (_) => getIt<InteractBloc>()),
            BlocProvider(create: (_) => getIt<CommentBloc>()),
            BlocProvider(create: (_) => getIt<UploadFileBloc>()),
            BlocProvider(
                create: (_) => getIt<ProfileBloc>()..add(FetchProfileEvent())),
            BlocProvider(create: (_) => getIt<PersonalBloc>()),
            BlocProvider(create: (_) => getIt<FriendBloc>()),
            BlocProvider(create: (_) => getIt<GroupBloc>()),
            BlocProvider(create: (_) => getIt<SearchBloc>()),
          ],
          child: BlocListener<AuthBloc, AuthState>(
            listenWhen: (_, current) =>
                current is AuthCheckSignInStatusSuccessState,
            listener: (_, state) {
              if (state is AuthCheckSignInStatusSuccessState) {
                router.pushReplacementNamed(AppRoute.appView.name);
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
