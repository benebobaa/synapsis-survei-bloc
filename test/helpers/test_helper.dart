import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synapsis_survei/data/data_sources/local_data_sources/login_local_data_source.dart';
import 'package:synapsis_survei/data/data_sources/remote_data_source.dart';
import 'package:synapsis_survei/data/data_sources/remote_data_sources/login_remote_data_source.dart';
import 'package:synapsis_survei/domain/repositories/login_repository.dart';
import 'package:synapsis_survei/domain/repositories/weather_repository.dart';
import 'package:synapsis_survei/domain/usecases/get_current_weather.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:synapsis_survei/domain/usecases/login_usecase.dart';

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeatherUsecase,
    LoginRepository,
    LoginRemoteDataSource,
    LoginLocalDataSource,
    LoginUsecase,
    Dio,
    SharedPreferences,
  ],
  // customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
@GenerateNiceMocks(
  [
    MockSpec<http.Client>(as: #MockHttpClient),
  ],
)
void main() {}
