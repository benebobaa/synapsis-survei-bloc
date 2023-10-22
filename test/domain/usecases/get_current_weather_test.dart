import 'package:dartz/dartz.dart';
import 'package:synapsis_survei/domain/entities/weather_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:synapsis_survei/domain/usecases/get_current_weather.dart';
import 'package:mockito/mockito.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUsecase getCurrentWeatherUsecase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUsecase = GetCurrentWeatherUsecase(mockWeatherRepository);
  });

  const testWeatherDetail = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few Clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  test(
    'should get current detail from the repository',
    () async {
      //arrange

      when(mockWeatherRepository.getCurrentWeather(testCityName))
          .thenAnswer((_) async => const Right(testWeatherDetail));

      //act
      final result = await getCurrentWeatherUsecase.execute(testCityName);

      //assert
      expect(result, const Right(testWeatherDetail));
    },
  );
}
