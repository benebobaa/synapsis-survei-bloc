import 'package:synapsis_survei/core/constants/api_urls.dart';
import 'package:synapsis_survei/core/error/exception.dart';
import 'package:synapsis_survei/data/data_sources/remote_data_source.dart';
import 'package:synapsis_survei/data/models/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/constants/dummy_data_json.dart';
import '../../helpers/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl = WeatherRemoteDataSourceImpl(
      client: mockHttpClient,
    );
  });

  const testCityName = 'New York';

  group('get current weather', () {
    test('should return weather model when the response code is 200', () async {
      //arrange
      when(
        mockHttpClient.get(
          Uri.parse(
            ApiUrls.currentWeatherByName(testCityName),
          ),
        ),
      ).thenAnswer(
        (_) async => http.Response(readJson(DummyData.weatherJson), 200),
      );

      //act
      final result =
          await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

      //assert

      expect(result, isA<WeatherModel>());
    });

    test(
        'should throw a server exception when the response code is 404 or other',
        () async {
      //arrange
      when(
        mockHttpClient.get(
          Uri.parse(
            ApiUrls.currentWeatherByName(testCityName),
          ),
        ),
      ).thenAnswer(
        (_) async => http.Response('Not found', 404),
      );

      //act
      final result =
          weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);

      //assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
