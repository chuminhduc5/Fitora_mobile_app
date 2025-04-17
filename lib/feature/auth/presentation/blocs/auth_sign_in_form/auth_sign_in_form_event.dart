part of 'auth_sign_in_form_bloc.dart';

@immutable
abstract class AuthSignInFormEvent extends Equatable {
  const AuthSignInFormEvent();

  @override
  List<Object?> get props => [];
}

// Sự kiện người dùng thay đổi email
class AuthSignInFormEmailChangedEvent extends AuthSignInFormEvent {
  final String email;

  const AuthSignInFormEmailChangedEvent(this.email);

  @override
  List<Object?> get props => [email];
}

// Sự kiện người dùng thay đổi password
class AuthSignInFormPasswordChangedEvent extends AuthSignInFormEvent {
  final String password;

  const AuthSignInFormPasswordChangedEvent(this.password);

  @override
  List<Object?> get props => [password];
}