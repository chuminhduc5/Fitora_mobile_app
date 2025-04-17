part of 'react_bloc.dart';

@immutable
abstract class ReactState extends Equatable{
  const ReactState();

  @override
  List<Object?> get props => [];
}

class ReactInitialState extends ReactState {}

// Psst React State
class ReactPostLoadingState extends ReactState {}

class ReactPostFailureState extends ReactState {}

class ReactPostSuccessState extends ReactState {}

// Post UnReact State
class UnReactPostLoadingState extends ReactState {}

class UnReactPostFailureState extends ReactState {}

class UnReactPostSuccessState extends ReactState {}