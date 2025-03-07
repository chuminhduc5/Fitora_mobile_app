import 'package:fitora_mobile_app/core/blocs/theme/theme_bloc.dart';
import 'package:fitora_mobile_app/core/blocs/translate/translate_bloc.dart';
import 'package:fitora_mobile_app/core/cache/hive_local_storage.dart';
import 'package:fitora_mobile_app/core/cache/secure_local_storage.dart';
import 'package:fitora_mobile_app/core/constants/api_url.dart';
import 'package:fitora_mobile_app/core/navigation/routes/app_route_conf.dart';
import 'package:fitora_mobile_app/core/network/network_checker.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/feature/auth/di/auth_dependency.dart';
import 'package:fitora_mobile_app/feature/chat/di/chat_dependency.dart';
import 'package:fitora_mobile_app/feature/communities/di/community_dependency.dart';
import 'package:fitora_mobile_app/feature/home/di/home_dependency.dart';
import 'package:fitora_mobile_app/feature/notification/di/notification_dependency.dart';
import 'package:fitora_mobile_app/feature/post/di/post_dependency.dart';
import 'package:fitora_mobile_app/feature/profile/di/profile_dependency.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

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
  getIt.registerLazySingleton(() => AppRouteConf());
  getIt.registerLazySingleton(() => DioClient(baseUrl: ApiUrl.authUrl), instanceName: 'auth');
  getIt.registerLazySingleton(() => DioClient(baseUrl: ApiUrl.userUrl), instanceName: 'user');
  getIt.registerLazySingleton(() => DioClient(baseUrl: ApiUrl.interactUrl), instanceName: 'interact');
  // getIt.registerSingleton<DioClient>(DioClient());
  
  getIt.registerLazySingleton(() => SecureLocalStorage(getIt<FlutterSecureStorage>()));
  getIt.registerLazySingleton(() => HiveLocalStorage());
  getIt.registerLazySingleton(() => NetworkChecker(getIt<InternetConnectionChecker>()));
  getIt.registerLazySingleton(() => const FlutterSecureStorage());
  getIt.registerLazySingleton(() => InternetConnectionChecker.createInstance());
}