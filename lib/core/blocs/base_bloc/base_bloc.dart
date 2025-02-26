import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitora_mobile_app/core/error/failure.dart';
import 'package:meta/meta.dart';

part 'base_event.dart';
part 'base_state.dart';

typedef EventHandlerType<T> = FutureOr<void> Function(
    T event,
    Emitter<BaseState> emit,
    );

typedef TransformerType<T> = Stream<T> Function(Stream<T>, Stream<T> Function(T))?;

abstract class BaseBloc extends Bloc<BaseEvent, BaseState> {
  BaseBloc(super.initialState) {
    on<BaseEvent>(onEveryEvent);
  }

  @override
  @mustCallSuper
  Future<void> close() {
    return super.close();
  }

  void onLoad<T extends BaseEvent>(EventHandlerType<T> handler,
      {TransformerType<T> transformer, LoadingState Function(T event)? loadingStateBuilder}) {
    on<T>(
          (event, emit) async {
        emit(loadingStateBuilder != null ? loadingStateBuilder(event) : LoadingState());
        await handler(event, emit);
      },
      transformer: transformer,
    );
  }

  FutureOr<void> onEveryEvent(BaseEvent event, Emitter<BaseState> emit) async {
    if (event is OnInitial) {
      emit(InitialState());
      return;
    }
  }
}

class ValidButtonBloc extends BaseBloc {
  ValidButtonBloc() : super(InitialState()) {
    onLoad<OnChange<bool>>((event, emit) {
      emit(DataLoadedState(event.value));
    });
  }
}

