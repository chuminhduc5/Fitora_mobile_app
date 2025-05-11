import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/usecase/usecase.dart';
import 'package:fitora_mobile_app/core/utils/failure_converter.dart';
import 'package:fitora_mobile_app/feature/user/domain/entities/user_entity.dart';
import 'package:fitora_mobile_app/feature/user/domain/usecases/users/get_users_use_case.dart';
import 'package:meta/meta.dart';

part 'users_event.dart';

part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  final GetUsersUseCase _getUsersUseCase;

  UsersBloc(this._getUsersUseCase) : super(FetchUsersInitialState()) {
    on<FetchUsersEvent>(_fetchUsers);
  }

  Future _fetchUsers(FetchUsersEvent event, Emitter emit) async {
    emit(FetchUsersLoadingState());

    final result = await _getUsersUseCase.call(NoParams());

    result.fold(
      (failure) => emit(FetchUsersFailureState(mapFailureToMessage(failure))),
      (success) => emit(FetchUsersSuccessState(data: success)),
    );
  }
}
