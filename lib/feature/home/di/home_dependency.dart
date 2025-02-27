import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/feature/home/data/datasources/newsfeed_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/home/data/repositories/newsfeed_repository_impl.dart';
import 'package:fitora_mobile_app/feature/home/doamin/usecases/get_newsfeed_use_case.dart';
import 'package:fitora_mobile_app/feature/home/presentation/blocs/newsfeed/newsfeed_bloc.dart';

class HomeDependency {
  HomeDependency._();

  static void init() {
    getIt.registerFactory(() => NewsfeedBloc(getIt<GetNewsfeedUseCase>()));

    getIt.registerLazySingleton(() => GetNewsfeedUseCase(getIt<NewsfeedRepositoryImpl>()));

    getIt.registerLazySingleton(() => NewsfeedRepositoryImpl(getIt<NewsfeedRemoteDataSourceImpl>()));
    
    getIt.registerLazySingleton(() => NewsfeedRemoteDataSourceImpl(getIt<DioClient>()));
  }
}