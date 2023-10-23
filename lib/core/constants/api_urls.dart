import 'package:synapsis_survei/core/constants/config_env.dart';

class ApiUrls {
  //boilerplate code
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';
  static const String apiKey = 'secret';
  static String currentWeatherByName(String cityName) =>
      '$baseUrl/weather?q=$cityName&appid=$apiKey';
  static String weatherIcon(String iconCode) =>
      'http://openweathermap.org/img/wn/$iconCode@2x.png';

  //project code
  static final String _baseUrl = ConfigEnvironments.getBaseUrlAPI() ?? '';
  static const String cookieKey = 'cookie';

  //login
  static String login = '$_baseUrl/api/login';
  //survey
  static String allSurvei = '$_baseUrl/api/survey';
  static String detailSurveyById(String surveiId) =>
      '$_baseUrl/api/survey/$surveiId';
}
