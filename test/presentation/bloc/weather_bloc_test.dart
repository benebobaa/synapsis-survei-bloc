import 'package:dartz/dartz.dart';
import 'package:synapsis_survei/core/error/failure.dart';
import 'package:synapsis_survei/domain/entities/weather_entity.dart';
import 'package:synapsis_survei/presentation/bloc/weather_bloc.dart';
import 'package:synapsis_survei/presentation/bloc/weather_event.dart';
import 'package:synapsis_survei/presentation/bloc/weather_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUsecase mockGetCurrentWeatherUsecase;
  late WeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeatherUsecase = MockGetCurrentWeatherUsecase();
    weatherBloc = WeatherBloc(mockGetCurrentWeatherUsecase);
  });

  const testWeather = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few Clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  test('initialState should be empty', () async {
    expect(weatherBloc.state, WeatherEmpty());
  });

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoaded] when data is gotten successfully',
    build: () {
      when(mockGetCurrentWeatherUsecase.execute(testCityName))
          .thenAnswer((_) async => const Right(testWeather));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChange(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoaded(result: testWeather),
    ],
  );

  blocTest<WeatherBloc, WeatherState>(
    'should emit [WeatherLoading, WeatherLoadFailure] when data is gotten unsuccessfully',
    build: () {
      when(mockGetCurrentWeatherUsecase.execute(testCityName))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChange(testCityName)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoading(),
      const WeatherLoadFailure('Server Failure'),
    ],
  );
}
