part of 'react_bloc.dart';

@immutable
abstract class ReactEvent extends Equatable{
  const ReactEvent();

  @override
  List<Object?> get props => [];
}

class ReactPostEvent extends ReactEvent {}

class UnReactPostEvent extends ReactEvent {}