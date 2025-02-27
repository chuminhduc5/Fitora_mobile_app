import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/feature/profile/data/datasources/personal_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/profile/data/repositories/personal_repository_impl.dart';
import 'package:fitora_mobile_app/feature/profile/domain/usecases/get_personal_use_case.dart';
import 'package:fitora_mobile_app/feature/profile/presentation/blocs/personal/personal_bloc.dart';

class ProfileDependency {
  ProfileDependency._();

  static void init() {
    getIt.registerFactory(() => PersonalBloc(getIt<GetPersonalUseCase>()));

    getIt.registerLazySingleton(() => GetPersonalUseCase(getIt<PersonalRepositoryImpl>()));

    getIt.registerLazySingleton(() => PersonalRepositoryImpl(getIt<PersonalRemoteDataSourceImpl>()));

    getIt.registerLazySingleton(() => PersonalRemoteDataSourceImpl(getIt<DioClient>()));
  }
}