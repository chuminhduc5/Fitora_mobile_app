part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

// Trạng thái đăng ký
class AuthSignUpLoadingState extends AuthState {}

class AuthSignUpSuccessState extends AuthState {
  final String message;

  const AuthSignUpSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthSignUpFailureState extends AuthState {
  final String message;

  const AuthSignUpFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// Trạng thái đăng nhập
class AuthSignInLoadingState extends AuthState {}

class AuthSignInSuccessState extends AuthState {
  final AuthEntity data;

  const AuthSignInSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class AuthSignInFailureState extends AuthState {
  final String message;

  const AuthSignInFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// Trạng thái đăng xuất
class AuthSignOutLoadingState extends AuthState {}

class AuthSignOutSuccessState extends AuthState {
  final String message;

  const AuthSignOutSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthSignOutFailureState extends AuthState {
  final String message;

  const AuthSignOutFailureState(this.message);

  @override
  List<Object?> get props => [message];
}

// Trạng thái kiểm tra trạng thái đăng nhập của người dùng
class AuthCheckSignInStatusLoadingState extends AuthState {}

class AuthCheckSignInStatusSuccessState extends AuthState {
  final AuthEntity data;

  const AuthCheckSignInStatusSuccessState({required this.data});

  @override
  List<Object?> get props => [data];
}

class AuthCheckSignInStatusFailureState extends AuthState {
  final String message;

  const AuthCheckSignInStatusFailureState(this.message);

  @override
  List<Object?> get props => [message];
}
