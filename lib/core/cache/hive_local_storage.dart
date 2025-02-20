import 'package:fitora_mobile_app/core/cache/local_storage.dart';
import 'package:hive/hive.dart';

class HiveLocalStorage implements LocalStorage {
  @override
  Future<void> delete({required String key, String? boxName}) async {
    await Hive.openBox(boxName!);
    final box = Hive.box(boxName);
    try {
      await box.delete(key);
      return;
    } catch (_) {
      rethrow;
    } finally {
      box.close();
    }
  }

  @override
  Future load({required String key, String? boxName}) async {
    await Hive.openBox(boxName!);
    final box = Hive.box(boxName);
    try {
      final result = await box.get(key);
      return result;
    } catch (_) {
      rethrow;
    } finally {
      box.close();
    }
  }

  @override
  Future<void> save({
    required String key,
    required value,
    String? boxName,
  }) async {
    await Hive.openBox(boxName!);
    final box = Hive.box(boxName);
    try {
      await box.put(key, value);
      return;
    } catch (_) {
      rethrow;
    } finally {
      box.close();
    }
  }
}
