import 'package:fitora_mobile_app/core/blocs/theme/theme_bloc.dart';
import 'package:fitora_mobile_app/core/blocs/translate/translate_bloc.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/feature/auth/di/auth_dependency.dart';
import 'package:fitora_mobile_app/feature/chat/di/chat_dependency.dart';
import 'package:fitora_mobile_app/feature/communities/di/community_dependency.dart';
import 'package:fitora_mobile_app/feature/home/di/home_dependency.dart';
import 'package:fitora_mobile_app/feature/notification/di/notification_dependency.dart';
import 'package:fitora_mobile_app/feature/post/di/post_dependency.dart';
import 'package:fitora_mobile_app/feature/profile/di/profile_dependency.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  AuthDependency.init();
  ChatDependency.init();
  CommunityDependency.init();
  HomeDependency.init();
  NotificationDependency.init();
  PostDependency.init();
  ProfileDependency.init();

  getIt.registerLazySingleton(() => ThemeBloc());
  getIt.registerLazySingleton(() => TranslateBloc());
  getIt.registerLazySingleton(() => DioClient());
  // getIt.registerSingleton<DioClient>(DioClient());
}