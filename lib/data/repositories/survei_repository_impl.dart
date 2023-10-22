// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:synapsis_survei/core/error/exception.dart';
import 'package:synapsis_survei/core/error/failure.dart';
import 'package:synapsis_survei/data/data_sources/local_data_sources/survei_local_darta_source.dart';
import 'package:synapsis_survei/data/data_sources/remote_data_sources/survei_remote_data_source.dart';
import 'package:synapsis_survei/domain/entities/all_survei_entity.dart';
import 'package:synapsis_survei/domain/entities/detail_survei_entity.dart';
import 'package:synapsis_survei/domain/repositories/survei_repository.dart';

class SurveiRepositoryImpl extends SurveiRepository {
  final SurveiRemoteDataSource surveiRemoteDataSource;
  final SurveiLocalDataSource surveiLocalDataSource;

  SurveiRepositoryImpl({
    required this.surveiRemoteDataSource,
    required this.surveiLocalDataSource,
  });

  @override
  Future<Either<Failure, AllSurveiEntity>> getAllSurvei() async {
    try {
      final result = await surveiRemoteDataSource.getAllSurvei();
      log('result survei $result');
      return Right(result.toEntity());
    } on ServerException {
      return const Left(
          ServerFailure('An error occurred while try to get all survei'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, DetailSurveiEntity>> getDetailSurvei(String surveiId) async{
    try {
      final result = await surveiRemoteDataSource.getDetailSurvei(surveiId);
      log('result survei $result');
      return Right(result.toEntity());
    } on ServerException {
      return const Left(
          ServerFailure('An error occurred while try to get all survei'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> getCookie() async {
    try {
      final result = await surveiLocalDataSource.getCookie();
      return Right(result);
    } on LocalDatabaseException {
      return const Left(
          DatabaseFailure('An error occurred while try to get cookie'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCookie() async {
    try {
      return Right(surveiLocalDataSource.deleteCookie());
    } on LocalDatabaseException {
      return const Left(
          DatabaseFailure('An error occurred while try to delete cookie'));
    }
  }
}
