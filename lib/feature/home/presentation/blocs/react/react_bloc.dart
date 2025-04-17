import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'react_event.dart';
part 'react_state.dart';

class ReactBloc extends Bloc<ReactEvent, ReactState> {
  ReactBloc() : super(ReactInitialState()) {
    on<ReactEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
