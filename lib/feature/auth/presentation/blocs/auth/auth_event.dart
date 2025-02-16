part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

// Sự kện người dùng đăng nhập
class AuthSignInEvent extends AuthEvent {
  final SignInReqParams params;

  const AuthSignInEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

// Sự kiện người dùng đăng ký
class AuthSignUpEvent extends AuthEvent {
  final SignUpReqParams params;

  const AuthSignUpEvent({required this.params});

  @override
  List<Object?> get props => [params];
}

// Sự kiện người dùng đăng xuất
class AuthSignOutEvent extends AuthEvent {}

/* Kiểm tra trạng thái đăng nhập của người dùng
* -> Nếu người dùng đã đăng nhập trước đó, chuyển đến màn hình HomeScreen
* -> Nếu người dùng chưa đăng nhâp, chuyển đến màn hình SignInScreen*/
class AuthCheckSignInStatusEvent extends AuthEvent {}
