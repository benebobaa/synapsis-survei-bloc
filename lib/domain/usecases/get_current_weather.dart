
import 'package:dartz/dartz.dart';
import 'package:synapsis_survei/core/error/failure.dart';
import 'package:synapsis_survei/domain/entities/weather_entity.dart';
import 'package:synapsis_survei/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUsecase{
  final WeatherRepository _weatherRepository;

  GetCurrentWeatherUsecase(this._weatherRepository);

  Future<Either<Failure,WeatherEntity>> execute(String cityName) async{
    return await _weatherRepository.getCurrentWeather(cityName);
  }
}