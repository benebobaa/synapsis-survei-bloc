import 'package:shared_preferences/shared_preferences.dart';

abstract class SurveiLocalDataSource {
  Future<String> getCookie();
  Future<void> deleteCookie();
}

class SurveiLocalDataSourceImpl extends SurveiLocalDataSource {
  final SharedPreferences sharedPreferences;

  SurveiLocalDataSourceImpl({required this.sharedPreferences});
  
  @override
  Future<String> getCookie() {
    try {
      return Future.value(sharedPreferences.getString('cookie') ?? '');
    } catch (e) {
      throw Exception();
    }
  }
  
  @override
  Future<void> deleteCookie() {
    try {
      return sharedPreferences.remove('cookie'); 
    } catch (e) {
      throw Exception();
    }
  }


  
}
