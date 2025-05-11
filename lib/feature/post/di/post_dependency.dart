import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/feature/post/data/datasources/category_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/post/data/datasources/comment_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/post/data/datasources/interact_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/post/data/datasources/post_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/post/data/repositories/category_repository_impl.dart';
import 'package:fitora_mobile_app/feature/post/data/repositories/comment_repository_impl.dart';
import 'package:fitora_mobile_app/feature/post/data/repositories/interact_repository_impl.dart';
import 'package:fitora_mobile_app/feature/post/data/repositories/post_repository_impl.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/category_repository.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/comment_repository.dart';
import 'package:fitora_mobile_app/feature/post/domain/repositories/interact_repository.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/categories/create_category_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/comments/create_comment_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/comments/get_comment_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/comments/update_comment_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/interact/vote_comment_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/interact/vote_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/posts/create_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/posts/delete_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/newsfeed/get_newsfeed_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/newsfeed/get_personal_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/posts/get_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/posts/update_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/comment/comment_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/comment_form/comment_form_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/interact/interact_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/newsfeed/newsfeed_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/post/post_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/post_form/post_form_bloc.dart';

class PostDependency {
  PostDependency._();

  static void init() {
    // Bloc
    getIt.registerFactory(() => PostBloc(getIt<CreatePostUseCase>()));
    getIt.registerFactory(() => PostFormBloc());
    getIt.registerFactory(() => NewsfeedBloc(getIt<GetNewsfeedUseCase>()));
    getIt.registerFactory(() => InteractBloc());
    getIt.registerFactory(() => CommentBloc(getIt<CreateCommentUseCase>(), getIt<GetCommentUseCase>()));
    getIt.registerFactory(() => CommentFormBloc());

    // UseCase - Post
    getIt.registerLazySingleton(() => GetPostUseCase(getIt<PostRepositoryImpl>()));
    getIt.registerLazySingleton(() => CreatePostUseCase(getIt<PostRepositoryImpl>()));
    getIt.registerLazySingleton(() => UpdatePostUseCase(getIt<PostRepositoryImpl>()));
    getIt.registerLazySingleton(() => DeletePostUseCase(getIt<PostRepositoryImpl>()));
    getIt.registerLazySingleton(() => GetNewsfeedUseCase(getIt<PostRepositoryImpl>()));
    getIt.registerLazySingleton(() => GetPersonalUseCase(getIt<PostRepositoryImpl>()));

    // UseCase - Interact
    getIt.registerLazySingleton(() => VotePostUseCase(getIt<InteractRepositoryImpl>()));
    getIt.registerLazySingleton(() => VoteCommentUseCase(getIt<InteractRepositoryImpl>()));

    // UseCase - Comment
    getIt.registerLazySingleton(() => GetCommentUseCase(getIt<CommentRepositoryImpl>()));
    getIt.registerLazySingleton(() => CreateCommentUseCase(getIt<CommentRepositoryImpl>()));
    getIt.registerLazySingleton(() => UpdateCommentUseCase(getIt<CommentRepositoryImpl>()));

    // UseCase - Category
    getIt.registerLazySingleton(() => CreateCategoryUseCase(getIt<CategoryRepositoryImpl>()));

    // Repository - Post
    getIt.registerLazySingleton(() => PostRepositoryImpl(getIt<PostRemoteDataSourceImpl>()));

    // Repository - Interact
    getIt.registerLazySingleton(() => InteractRepositoryImpl(getIt<InteractRemoteDataSourceImpl>()));

    // Repository - Comment
    getIt.registerLazySingleton(() => CommentRepositoryImpl(getIt<CommentRemoteDataSourceImpl>()));

    // Repository - Category
    getIt.registerLazySingleton(() => CategoryRepositoryImpl(getIt<CategoryRemoteDataSourceImpl>()));

    // Datasource
    getIt.registerLazySingleton(() => PostRemoteDataSourceImpl(getIt<DioClient>(instanceName: 'interact')));
    getIt.registerLazySingleton(() => InteractRemoteDataSourceImpl(getIt<DioClient>(instanceName: 'interact')));
    getIt.registerLazySingleton(() => CommentRemoteDataSourceImpl(getIt<DioClient>(instanceName: 'interact')));
    getIt.registerLazySingleton(() => CategoryRemoteDataSourceImpl(getIt<DioClient>(instanceName: 'interact')));
  }
}
