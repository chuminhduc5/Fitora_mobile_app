import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/feature/post/data/datasources/post_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/post/data/repositories/post_repository_impl.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/create_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/delete_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/get_newsfeed_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/get_personal_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/get_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/update_post_use_case.dart';

class PostDependency {
  PostDependency._();

  static void init() {
    // Bloc

    // UseCase
    getIt.registerLazySingleton(() => GetPostUseCase(getIt<PostRepositoryImpl>()));
    getIt.registerLazySingleton(() => CreatePostUseCase(getIt<PostRepositoryImpl>()));
    getIt.registerLazySingleton(() => UpdatePostUseCase(getIt<PostRepositoryImpl>()));
    getIt.registerLazySingleton(() => DeletePostUseCase(getIt<PostRepositoryImpl>()));
    getIt.registerLazySingleton(() => GetNewsfeedUseCase(getIt<PostRepositoryImpl>()));
    getIt.registerLazySingleton(() => GetPersonalUseCase(getIt<PostRepositoryImpl>()));

    // Repository
    getIt.registerLazySingleton(() => PostRepositoryImpl(getIt<PostRemoteDataSourceImpl>()));

    // Datasource
    getIt.registerLazySingleton(() => PostRemoteDataSourceImpl(getIt<DioClient>(instanceName: 'interact')));
  }
}