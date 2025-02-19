import 'package:fitora_mobile_app/core/error/failure.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return "Server Failure";
    case CacheFailure:
      return "Cache Failure";
    case EmptyFailure:
      return "Empty Failure";
    case CredentialFailure:
      return "Wrong Email or Password";
    case DuplicateEmailFailure:
      return "Email already taken";
    case PasswordNotMatchFailure:
      return "Password not match";
    case InvalidEmailFailure:
      return "Định dạng email không hợp lệ";
    case InvalidPasswordFailure:
      return "Định dạng mật khẩu không hợp lệ";
    default:
      return "Unexpected error";
  }
}