import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/feature/friends/data/datasources/friend_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/friends/data/repositories/friend_repository_impl.dart';
import 'package:fitora_mobile_app/feature/friends/domain/usecases/accept_friend_use_case.dart';
import 'package:fitora_mobile_app/feature/friends/domain/usecases/add_friend_use_case.dart';
import 'package:fitora_mobile_app/feature/friends/domain/usecases/delete_friend_use_case.dart';
import 'package:fitora_mobile_app/feature/friends/domain/usecases/get_friend_use_case.dart';
import 'package:fitora_mobile_app/feature/friends/domain/usecases/get_received_friend_request_use_case.dart';
import 'package:fitora_mobile_app/feature/friends/domain/usecases/get_recommend_user_use_case.dart';
import 'package:fitora_mobile_app/feature/friends/domain/usecases/get_sent_friend_request_use_case.dart';
import 'package:fitora_mobile_app/feature/friends/domain/usecases/unfriend_use_case.dart';
import 'package:fitora_mobile_app/feature/friends/presentation/blocs/friend/friend_bloc.dart';

class FriendDependency {
  FriendDependency._();

  static void init() {
    getIt.registerFactory(
      () => FriendBloc(
        getIt<AddFriendUseCase>(),
        getIt<AcceptFriendUseCase>(),
        getIt<DeleteFriendUseCase>(),
        getIt<UnfriendUseCase>(),
        getIt<GetFriendUseCase>(),
        getIt<GetSentFriendRequestUseCase>(),
        getIt<GetReceivedFriendRequestUseCase>(),
        getIt<GetRecommendUserUseCase>(),
      ),
    );

    getIt.registerLazySingleton(() => AddFriendUseCase(getIt<FriendRepositoryImpl>()));
    getIt.registerLazySingleton(() => AcceptFriendUseCase(getIt<FriendRepositoryImpl>()));
    getIt.registerLazySingleton(() => DeleteFriendUseCase(getIt<FriendRepositoryImpl>()));
    getIt.registerLazySingleton(() => UnfriendUseCase(getIt<FriendRepositoryImpl>()));
    getIt.registerLazySingleton(() => GetFriendUseCase(getIt<FriendRepositoryImpl>()));
    getIt.registerLazySingleton(() => GetSentFriendRequestUseCase(getIt<FriendRepositoryImpl>()));
    getIt.registerLazySingleton(() => GetReceivedFriendRequestUseCase(getIt<FriendRepositoryImpl>()));
    getIt.registerLazySingleton(() => GetRecommendUserUseCase(getIt<FriendRepositoryImpl>()));

    getIt.registerLazySingleton(() => FriendRepositoryImpl(getIt<FriendRemoteDataSourceImpl>()));

    getIt.registerLazySingleton(() => FriendRemoteDataSourceImpl(getIt<DioClient>(instanceName: 'user')));
  }
}
