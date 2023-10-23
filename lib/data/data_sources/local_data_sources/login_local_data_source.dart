import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synapsis_survei/core/error/exception.dart';
import 'package:synapsis_survei/core/services/local_auth.dart';

abstract class LoginLocalDataSource {
  Future<String> getEmailCache(String key);
  Future<void> saveEmailCache(String key, String email);
  Future<void> deleteEmailCache(String key);
  Future<String> loginFingerprint(String key);
  Future<void> deleteCookie(String key);
}

class LoginLocalDataSourceImpl extends LoginLocalDataSource {
  final SharedPreferences sharedPreferences;
  final LocalAuthFingerprint localAuthFingerprint;

  LoginLocalDataSourceImpl(
      {required this.sharedPreferences, required this.localAuthFingerprint});

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
      final result = await localAuthFingerprint.authenticate();
      if (result) {
        return Future.value(sharedPreferences.getString(key) ?? '');
      } else {
        throw FingerprintException();
      }
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code);
    }
  }

  @override
  Future<void> deleteCookie(String key) {
    try {
      return sharedPreferences.remove(key);
    } catch (e) {
      throw Exception();
    }
  }
}
