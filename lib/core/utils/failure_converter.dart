import 'package:fitora_mobile_app/core/error/failure.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure():
      return "Lỗi máy chủ";
    case CacheFailure():
      return "Lỗi bộ nhớ đệm";
    case EmptyFailure():
      return "Lỗi trống";
    case CredentialFailure():
      return "Email hoặc mật khẩu sai";
    case DuplicateEmailFailure():
      return "Email đã được sử dụng";
    case PasswordNotMatchFailure():
      return "Mật khẩu không khớp";
    case InvalidEmailFailure():
      return "Định dạng email không hợp lệ";
    case InvalidPasswordFailure():
      return "Định dạng mật khẩu không hợp lệ";
    case DataInputFailure():
      return "Dữ liệu nhập vào không chính xác";
    case NetworkFailure():
      return "Lỗi kết nối mạng";
    case ConnectionFailure():
      return "Lỗi kết nối, kết nối thất bại";
    default:
      return "Lỗi";
  }
}