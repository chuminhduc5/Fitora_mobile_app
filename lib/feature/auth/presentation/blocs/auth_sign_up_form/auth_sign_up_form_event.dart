part of 'auth_sign_up_form_bloc.dart';

@immutable
abstract class AuthSignUpFormEvent extends Equatable {
  const AuthSignUpFormEvent();

  @override
  List<Object?> get props => [];
}

// Sự kiện thay đổi email
class SignUpFormEmailChangedEvent extends AuthSignUpFormEvent {
  final String email;

  const SignUpFormEmailChangedEvent(this.email);

  @override
  List<Object?> get props => [email];
}

// Sự kiện thay đổi username
class SignUpFormUsernameChangedEvent extends AuthSignUpFormEvent {
  final String username;

  const SignUpFormUsernameChangedEvent(this.username);

  @override
  List<Object?> get props => [username];
}

// Sự kiện thay đổi password
class SignUpFormPasswordChangedEvent extends AuthSignUpFormEvent {
  final String password;

  const SignUpFormPasswordChangedEvent(this.password);

  @override
  List<Object?> get props => [password];
}

// Sự kiện thay đổi confirm password
class SignUpFormConfirmPasswordChangedEvent extends AuthSignUpFormEvent {
  final String confirmPassword;

  const SignUpFormConfirmPasswordChangedEvent(this.confirmPassword);

  @override
  List<Object?> get props => [confirmPassword];
}
