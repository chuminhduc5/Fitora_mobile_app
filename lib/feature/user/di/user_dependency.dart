import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/core/service/api/dio_client.dart';
import 'package:fitora_mobile_app/feature/user/data/datasources/friend_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/user/data/datasources/group_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/user/data/datasources/user_remote_data_source.dart';
import 'package:fitora_mobile_app/feature/user/data/repositories/friend_repository_impl.dart';
import 'package:fitora_mobile_app/feature/user/data/repositories/group_repository_impl.dart';
import 'package:fitora_mobile_app/feature/user/data/repositories/user_repository_impl.dart';
import 'package:fitora_mobile_app/feature/user/domain/repositories/friend_repository.dart';
import 'package:fitora_mobile_app/feature/user/domain/repositories/group_repository.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/friends/accept_friend_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/friends/add_friend_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/friends/delete_friend_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/friends/get_friend_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/friends/get_received_friend_request_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/friends/get_sent_friend_request_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/friends/unfriend_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/groups/accept_group_invite_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/groups/create_group_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/groups/get_group_by_id_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/groups/get_group_member_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/groups/get_managed_group_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/groups/get_received_group_invite_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/groups/invite_new_members_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/users/get_personal_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/users/get_profile_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/users/get_users_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/users/update_profile_use_case.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/friend/friend_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/group/group_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/group_form/group_form_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/personal/personal_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/profile/profile_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/profile_form/profile_form_bloc.dart';
import 'package:fitora_mobile_app/feature/user/presentation/blocs/users/users_bloc.dart';

class UserDependency {
  UserDependency._();

  static void init() {
    // Bloc
    getIt.registerFactory(() => UsersBloc(getIt<GetUsersUseCase>()));
    getIt.registerFactory(() => ProfileBloc(
          getIt<GetProfileUseCase>(),
          getIt<UpdateProfileUseCase>(),
        ));
    getIt.registerFactory(() => ProfileFormBloc());
    getIt.registerFactory(() => PersonalBloc(getIt<GetPersonalUseCase>()));
    getIt.registerFactory(() => GroupBloc(
          getIt<CreateGroupUseCase>(),
          getIt<GetGroupByIdUseCase>(),
          getIt<GetGroupMemberUseCase>(),
          getIt<InviteNewMembersUseCase>(),
          getIt<GetReceivedGroupInviteUseCase>(),
          getIt<AcceptGroupInviteUseCase>(),
          getIt<GetManagedGroupUseCase>(),
        ));
    getIt.registerFactory(() => GroupFormBloc());
    getIt.registerFactory(() => FriendBloc(
          getIt<AddFriendUseCase>(),
          getIt<AcceptFriendUseCase>(),
          getIt<DeleteFriendUseCase>(),
          getIt<UnfriendUseCase>(),
          getIt<GetFriendUseCase>(),
          getIt<GetSentFriendRequestUseCase>(),
          getIt<GetReceivedFriendRequestUseCase>(),
        ));

    // UseCase - User
    getIt.registerLazySingleton(
        () => GetUsersUseCase(getIt<UserRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => GetProfileUseCase(getIt<UserRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => GetPersonalUseCase(getIt<UserRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => UpdateProfileUseCase(getIt<UserRepositoryImpl>()));

    // UseCase - Group
    getIt.registerLazySingleton(
        () => CreateGroupUseCase(getIt<GroupRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => GetGroupByIdUseCase(getIt<GroupRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => GetGroupMemberUseCase(getIt<GroupRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => InviteNewMembersUseCase(getIt<GroupRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => GetReceivedGroupInviteUseCase(getIt<GroupRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => AcceptGroupInviteUseCase(getIt<GroupRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => GetManagedGroupUseCase(getIt<GroupRepositoryImpl>()));

    // UseCase - Friend
    getIt.registerLazySingleton(
        () => AddFriendUseCase(getIt<FriendRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => AcceptFriendUseCase(getIt<FriendRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => DeleteFriendUseCase(getIt<FriendRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => UnfriendUseCase(getIt<FriendRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => GetFriendUseCase(getIt<FriendRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => GetSentFriendRequestUseCase(getIt<FriendRepositoryImpl>()));
    getIt.registerLazySingleton(
        () => GetReceivedFriendRequestUseCase(getIt<FriendRepositoryImpl>()));

    // Repository
    getIt.registerLazySingleton(
        () => UserRepositoryImpl(getIt<UserRemoteDataSourceImpl>()));
    getIt.registerLazySingleton(
        () => GroupRepositoryImpl(getIt<GroupRemoteDataSourceImpl>()));
    getIt.registerLazySingleton(
        () => FriendRepositoryImpl(getIt<FriendRemoteDataSourceImpl>()));

    // Datasource
    getIt.registerLazySingleton(
        () => UserRemoteDataSourceImpl(getIt<DioClient>(instanceName: 'user')));
    getIt.registerLazySingleton(() =>
        GroupRemoteDataSourceImpl(getIt<DioClient>(instanceName: 'user')));
    getIt.registerLazySingleton(() =>
        FriendRemoteDataSourceImpl(getIt<DioClient>(instanceName: 'user')));
  }
}
