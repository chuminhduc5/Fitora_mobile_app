part of 'personal_bloc.dart';

@immutable
abstract class PersonalState extends Equatable {
  const PersonalState();

  @override
  List<Object?> get props => [];
}

class FetchPersonalInitialState extends PersonalState {}

class FetchPersonalLoadingState extends PersonalState {}

class FetchPersonalSuccessState extends PersonalState {
  final PersonalEntity data;

  const FetchPersonalSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchPersonalFailureState extends PersonalState {
  final String message;

  const FetchPersonalFailureState({required this.message});
}
