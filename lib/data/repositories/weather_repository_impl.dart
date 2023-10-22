import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:synapsis_survei/core/error/exception.dart';
import 'package:synapsis_survei/core/error/failure.dart';
import 'package:synapsis_survei/data/data_sources/remote_data_source.dart';
import 'package:synapsis_survei/domain/entities/weather_entity.dart';
import 'package:synapsis_survei/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepositoryImpl({required this.weatherRemoteDataSource});
  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    try {
      final result = await weatherRemoteDataSource.getCurrentWeather(cityName);
      log('succes get data: $result');
      return Right(result.toEntity());
    } on ServerException {
      return const Left(
          ServerFailure('An error occurred while getting weather data'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
