import 'package:fitora_mobile_app/core/di/injection.dart';
import 'package:fitora_mobile_app/feature/notification/presentation/blocs/notification_bloc.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/friends/get_received_friend_request_use_case.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/groups/get_received_group_invite_use_case.dart';

class NotificationDependency {
  NotificationDependency._();

  static void init() {
    // Bloc
    getIt.registerFactory(
      () => NotificationBloc(
        getIt<GetReceivedFriendRequestUseCase>(),
        getIt<GetReceivedGroupInviteUseCase>(),
      ),
    );

    // UseCase

    // Repository

    // Datasource
  }
}
