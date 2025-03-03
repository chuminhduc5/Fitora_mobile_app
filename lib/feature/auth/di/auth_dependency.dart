import 'package:fitora_mobile_app/core/cache/hive_local_storage.dart';
import 'package:fitora_mobile_app/core/cache/secure_local_storage.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/feature/auth/data/datasources/auth_local_data_source.dart';
import 'package:fitora_mobile_app/feature/auth/data/datasources/auth_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/auth/data/repositories/auth_repository_impl.dart';
import 'package:fitora_mobile_app/feature/auth/domain/usecases/auth_check_sign_in_status_use_case.dart';
import 'package:fitora_mobile_app/feature/auth/domain/usecases/auth_sign_in_use_case.dart';
import 'package:fitora_mobile_app/feature/auth/domain/usecases/auth_sign_out_use_case.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth/auth_bloc.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth_sign_in_form/auth_sign_in_form_bloc.dart';
import 'package:fitora_mobile_app/feature/auth/presentation/blocs/auth_sign_up_form/auth_sign_up_form_bloc.dart';

import '../domain/usecases/auth_sign_up_use_case.dart';

class AuthDependency {
  AuthDependency._();

  static void init() {
    // Bloc - Đăng ký Bloc Dependency
    getIt.registerFactory(
      () => AuthBloc(
        getIt<AuthSignInUseCase>(),
        getIt<AuthSignUpUseCase>(),
        getIt<AuthSignOutUseCase>(),
        getIt<AuthCheckSignInStatusUseCase>(),
      ),
    );
    getIt.registerFactory(() => AuthSignInFormBloc());
    getIt.registerFactory(() => AuthSignUpFormBloc());

    // UseCase - Đăng ký UseCase Dependency
    getIt.registerLazySingleton(
        () => AuthSignInUseCase(getIt<AuthRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => AuthSignUpUseCase(getIt<AuthRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => AuthSignOutUseCase(getIt<AuthRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => AuthCheckSignInStatusUseCase(getIt<AuthRepositoryImpl>()));

    // Repository - Đăng ký Repository Dependency
    getIt.registerLazySingleton(() => AuthRepositoryImpl(
          getIt<AuthRemoteDataSourceImpl>(),
          getIt<AuthLocalDataSourceImpl>(),
          getIt<SecureLocalStorage>(),
          getIt<HiveLocalStorage>(),
        ));

    // Service - Đăng ký Service Dependency
    getIt.registerLazySingleton(
        () => AuthRemoteDataSourceImpl(getIt<DioClient>()));
  }
}
