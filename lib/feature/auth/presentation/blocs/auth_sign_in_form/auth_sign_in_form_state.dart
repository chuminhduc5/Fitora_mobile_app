part of 'auth_sign_in_form_bloc.dart';

@immutable
abstract class AuthSignInFormState extends Equatable {
  const AuthSignInFormState();

  @override
  List<Object?> get props => [];
}

class AuthSignInFormInitial extends AuthSignInFormState {}
