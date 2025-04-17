import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/feature/profile/data/datasources/profile_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/profile/data/repositories/profile_repository_impl.dart';
import 'package:fitora_mobile_app/feature/profile/domain/usecases/get_personal_use_case.dart';
import 'package:fitora_mobile_app/feature/profile/domain/usecases/get_profile_use_case.dart';
import 'package:fitora_mobile_app/feature/profile/domain/usecases/update_profile_use_case.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/blocs/personal/personal_bloc.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/blocs/profile/profile_bloc.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/blocs/profile_form/profile_form_bloc.dart';

class ProfileDependency {
  ProfileDependency._();

  static void init() {
    // Bloc
    getIt.registerFactory(
      () => ProfileBloc(
        getIt<GetProfileUseCase>(),
        getIt<UpdateProfileUseCase>(),
      ),
    );

    getIt.registerFactory(() => ProfileFormBloc());

    getIt.registerFactory(() => PersonalBloc(getIt<GetPersonalUseCase>()));

    // UseCase
    getIt.registerLazySingleton(
      () => GetProfileUseCase(
        getIt<ProfileRepositoryImpl>(),
      ),
    );

    getIt.registerLazySingleton(() => GetPersonalUseCase(getIt<ProfileRepositoryImpl>()));

    getIt.registerLazySingleton(
      () => UpdateProfileUseCase(
        getIt<ProfileRepositoryImpl>(),
      ),
    );

    // Repository
    getIt.registerLazySingleton(
      () => ProfileRepositoryImpl(
        getIt<ProfileRemoteDataSourceImpl>(),
      ),
    );

    // Datasource
    getIt.registerLazySingleton(
      () => ProfileRemoteDataSourceImpl(
        getIt<DioClient>(instanceName: 'user'),
      ),
    );
  }
}
