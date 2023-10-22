import 'package:shared_preferences/shared_preferences.dart';
import 'package:synapsis_survei/core/error/exception.dart';

abstract class LoginLocalDataSource {
  Future<String> getEmailCache(String key);
  Future<void> saveEmailCache(String key, String email);
  Future<void> deleteEmailCache(String key);
  Future<String> loginFingerprint(String key);
}

class LoginLocalDataSourceImpl extends LoginLocalDataSource {
  final SharedPreferences sharedPreferences;

  LoginLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> saveEmailCache(String key, String email) async {
    try {
      await sharedPreferences.setString(key, email);
    } catch (e) {
      throw LocalDatabaseException();
    }
  }

  @override
  Future<String> getEmailCache(String key) {
    try {
      return Future.value(sharedPreferences.getString(key) ?? '');
    } catch (e) {
      throw LocalDatabaseException();
    }
  }

  @override
  Future<void> deleteEmailCache(String key) {
    try {
      return sharedPreferences.remove(key);
    } catch (e) {
      throw LocalDatabaseException();
    }
  }

  @override
  Future<String> loginFingerprint(String key) async {
    try {
      return Future.value(sharedPreferences.getString(key) ?? '');
    } catch (e) {
      throw LocalDatabaseException();
    }
  }
}
