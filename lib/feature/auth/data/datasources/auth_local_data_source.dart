import 'package:fitora_mobile_app/core/cache/hive_local_storage.dart';
import 'package:fitora_mobile_app/core/cache/secure_local_storage.dart';
import 'package:fitora_mobile_app/core/error/exceptions.dart';
import 'package:fitora_mobile_app/core/utils/logger.dart';
import 'package:fitora_mobile_app/feature/auth/domain/entities/auth_entity.dart';
import 'package:fitora_mobile_app/feature/user/data/models/responses/user_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<AuthEntity> checkSignInStatus();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureLocalStorage _secureLocalStorage;
  final HiveLocalStorage _hiveLocalStorage;

  const AuthLocalDataSourceImpl(
    this._secureLocalStorage,
    this._hiveLocalStorage,
  );

  @override
  Future<AuthEntity> checkSignInStatus() async {
    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();
      final token = pref.getString('token');
      final userId = await _secureLocalStorage.load(key: "user_id");
      final result = await _hiveLocalStorage.load(key: "user", boxName: "cache");
      if (token != null &&token.isNotEmpty) {
        if (result is AuthEntity) {
          return result;
        }
      }
      throw CacheException();
    } catch (e) {
      logger.e(e);
      throw CacheException();
    }
  }
}
