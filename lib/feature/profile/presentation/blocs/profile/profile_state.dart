part of 'profile_bloc.dart';

@immutable
abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitialState extends ProfileState {}

class FetchProfileLoadingState extends ProfileState {}

class FetchProfileSuccessState extends ProfileState {
  final ProfileEntity data;

  const FetchProfileSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class FetchProfileFailureState extends ProfileState {
  final String message;

  const FetchProfileFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
