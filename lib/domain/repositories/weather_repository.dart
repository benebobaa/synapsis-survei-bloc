import 'package:dartz/dartz.dart';
import 'package:synapsis_survei/core/error/failure.dart';
import 'package:synapsis_survei/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<Either<Failure,WeatherEntity>> getCurrentWeather(String cityName);
}
