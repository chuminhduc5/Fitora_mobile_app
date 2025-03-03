import 'package:easy_localization/easy_localization.dart';

class ErrorHandler {
  static final errors = {
    "Email or password is incorrect": 'email_or_pass_incorrect'.tr(),
    "Token expired": 'token_expired'.tr(),
  };

  static String? parse(String error, {bool shouldUseDefaultError = true, String? defaultError}) {
    if (error.indexOf("E_NGW001") == 0) {
      return error.replaceAll("E_NGW001", "");
    }
    if (error.indexOf("E_ACC002") == 0) {
      return error.replaceAll("E_ACC002", "");
    }
    if (error.indexOf("E_ACC004") == 0) {
      return error.replaceAll("E_ACC004", "");
    }
    if (error.indexOf("E_SEN001") == 0) {
      return error.replaceAll("E_SEN001", "");
    }
    if (defaultError != null || shouldUseDefaultError) {
      return defaultError ?? 'an_error_has_occured'.tr();
    }
    return errors.containsKey(error) ? errors[error] : error;
  }
}

class NetWorkException implements Exception{}

class ServerException implements Exception{}

class CacheException implements Exception{}

class AuthException implements Exception {}

class EmptyException implements Exception {}

class DuplicateEmailException implements Exception {}