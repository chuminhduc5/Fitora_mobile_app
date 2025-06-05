import 'package:fitora_mobile_app/core/cache/hive_local_storage.dart';
import 'package:fitora_mobile_app/core/cache/secure_local_storage.dart';
import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/feature/post/data/datasources/category_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/post/data/datasources/comment_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/post/data/datasources/interact_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/post/data/datasources/post_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/post/data/datasources/upload_file_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/post/data/repositories/category_repository_impl.dart';
import 'package:fitora_mobile_app/feature/post/data/repositories/comment_repository_impl.dart';
import 'package:fitora_mobile_app/feature/post/data/repositories/interact_repository_impl.dart';
import 'package:fitora_mobile_app/feature/post/data/repositories/post_repository_impl.dart';
import 'package:fitora_mobile_app/feature/post/data/repositories/upload_file_repository_impl.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/categories/create_category_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/comments/create_comment_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/comments/get_comment_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/comments/get_replies_comment_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/comments/update_comment_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/interact/vote_comment_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/interact/vote_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/newsfeed/get_explore_feed_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/newsfeed/get_trending_feed_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/posts/create_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/posts/delete_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/newsfeed/get_newsfeed_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/newsfeed/get_user_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/posts/get_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/posts/get_saved_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/posts/save_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/posts/update_post_use_case.dart';
import 'package:fitora_mobile_app/feature/post/domain/usecases/posts/upload_file_use_case.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/comment/comment_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/comment_form/comment_form_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/interact/interact_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/newsfeed/newsfeed_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/post/post_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/post_form/post_form_bloc.dart';
import 'package:fitora_mobile_app/feature/post/presentation/blocs/upload_file/upload_file_bloc.dart';

class PostDependency {
  PostDependency._();

  static void init() {
    // Bloc
    getIt.registerFactory(
      () => PostBloc(
        getIt<CreatePostUseCase>(),
        getIt<UpdatePostUseCase>(),
        getIt<DeletePostUseCase>(),
        getIt<SavePostUseCase>(),
      ),
    );
    getIt.registerFactory(() => PostFormBloc());
    getIt.registerFactory(
      () => NewsfeedBloc(
        getIt<GetNewsfeedUseCase>(),
        getIt<GetTrendingFeedUseCase>(),
        getIt<GetExploreFeedUseCase>(),
      ),
    );
    getIt.registerFactory(() => InteractBloc(getIt<VotePostUseCase>()));
    // getIt.registerFactoryParam<InteractBloc, int, int?>(
    //       (voteCount, userVoteType) => InteractBloc(
    //     votePostUseCase: getIt<VotePostUseCase>(),
    //     initialVoteCount: voteCount,
    //     initialUserVoteType: userVoteType,
    //   ),
    // );

    getIt.registerFactory(
      () => CommentBloc(
        getIt<CreateCommentUseCase>(),
        getIt<GetCommentUseCase>(),
        getIt<GetRepliesCommentUseCase>(),
      ),
    );
    getIt.registerFactory(() => CommentFormBloc());
    getIt.registerFactory(() => UploadFileBloc(getIt<UploadFileUseCase>()));

    // UseCase - Post
    getIt.registerLazySingleton(
        () => GetPostUseCase(getIt<PostRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => CreatePostUseCase(getIt<PostRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => UpdatePostUseCase(getIt<PostRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => DeletePostUseCase(getIt<PostRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => GetNewsfeedUseCase(getIt<PostRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => GetUserPostUseCase(getIt<PostRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => SavePostUseCase(getIt<PostRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => GetSavedPostUseCase(getIt<PostRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => GetTrendingFeedUseCase(getIt<PostRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => GetExploreFeedUseCase(getIt<PostRepositoryImpl>()));

    // UseCase - Interact
    getIt.registerLazySingleton(
        () => VotePostUseCase(getIt<InteractRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => VoteCommentUseCase(getIt<InteractRepositoryImpl>()));

    // UseCase - Comment
    getIt.registerLazySingleton(
        () => GetCommentUseCase(getIt<CommentRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => GetRepliesCommentUseCase(getIt<CommentRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => CreateCommentUseCase(getIt<CommentRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => UpdateCommentUseCase(getIt<CommentRepositoryImpl>()));

    // UseCase - Category
    getIt.registerLazySingleton(
        () => CreateCategoryUseCase(getIt<CategoryRepositoryImpl>()));

    // UseCase = UploadFile
    getIt.registerLazySingleton(
        () => UploadFileUseCase(getIt<UploadFileRepositoryImpl>()));

    // Repository - Post
    getIt.registerLazySingleton(
      () => PostRepositoryImpl(
        getIt<PostRemoteDataSourceImpl>(),
        getIt<SecureLocalStorage>(),
        getIt<HiveLocalStorage>(),
      ),
    );

    // Repository - Interact
    getIt.registerLazySingleton(
        () => InteractRepositoryImpl(getIt<InteractRemoteDataSourceImpl>()));

    // Repository - Comment
    getIt.registerLazySingleton(() => CommentRepositoryImpl(
          getIt<CommentRemoteDataSourceImpl>(),
          getIt<SecureLocalStorage>(),
          getIt<HiveLocalStorage>(),
        ));

    // Repository - Category
    getIt.registerLazySingleton(
        () => CategoryRepositoryImpl(getIt<CategoryRemoteDataSourceImpl>()));

    // Repository - UploadFile
    getIt.registerLazySingleton(() =>
        UploadFileRepositoryImpl(getIt<UploadFileRemoteDataSourceImpl>()));

    // Datasource
    getIt.registerLazySingleton(() =>
        PostRemoteDataSourceImpl(getIt<DioClient>(instanceName: 'interact')));
    getIt.registerLazySingleton(() => InteractRemoteDataSourceImpl(
        getIt<DioClient>(instanceName: 'interact')));
    getIt.registerLazySingleton(() => CommentRemoteDataSourceImpl(
        getIt<DioClient>(instanceName: 'interact')));
    getIt.registerLazySingleton(() => CategoryRemoteDataSourceImpl(
        getIt<DioClient>(instanceName: 'interact')));
    getIt.registerLazySingleton(() => UploadFileRemoteDataSourceImpl(
        getIt<DioClient>(instanceName: 'interact')));
  }
}
