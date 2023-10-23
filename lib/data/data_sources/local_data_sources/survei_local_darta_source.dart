import 'package:shared_preferences/shared_preferences.dart';

abstract class SurveiLocalDataSource {
  Future<String> getCookie(String key);
}

class SurveiLocalDataSourceImpl extends SurveiLocalDataSource {
  final SharedPreferences sharedPreferences;

  SurveiLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<String> getCookie(String key) {
    try {
      return Future.value(sharedPreferences.getString(key) ?? '');
    } catch (e) {
      throw Exception();
    }
  }

  
}
