import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:synapsis_survei/core/error/exception.dart';
import 'package:synapsis_survei/core/error/failure.dart';
import 'package:synapsis_survei/data/data_sources/local_data_sources/login_local_data_source.dart';
import 'package:synapsis_survei/data/data_sources/remote_data_sources/login_remote_data_source.dart';
import 'package:synapsis_survei/domain/entities/login_success_entity.dart';
import 'package:synapsis_survei/domain/repositories/login_repository.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;
  final LoginLocalDataSource loginLocalDataSource;

  LoginRepositoryImpl(
      {required this.loginRemoteDataSource,
      required this.loginLocalDataSource});

  @override
  Future<Either<Failure, LoginSuccessEntity>> postLogin(
      String email, String password) async {
    try {
      final result = await loginRemoteDataSource.postLogin(email, password);
      return Right(result.toEntity());
    } on BadRequestException catch (e) {
      return Left(LoginFailed(e.message));
    } on ServerException {
      return const Left(ServerFailure('An error occurred while try to login'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> getEmailCache(String key) async {
    try {
      final result = await loginLocalDataSource.getEmailCache(key);
      return Right(result);
    } on LocalDatabaseException {
      return const Left(
          DatabaseFailure('An error occurred while try to get email cache'));
    }
  }

  @override
  Future<Either<Failure, void>> saveEmailCache(String key, String email) async {
    try {
      return Right(loginLocalDataSource.saveEmailCache(key, email));
    } on LocalDatabaseException {
      return const Left(
          DatabaseFailure('An error occurred while try to save email cache'));
    }
  }

  @override
  Future<Either<Failure, String>> loginFingerprint(String key) async {
    try {
      final result = await loginLocalDataSource.loginFingerprint(key);
      return Right(result);
    } on PlatformException {
      return const Left(LoginFailed(
          'Your device does not support fingerprint or does not have fingerprint registered'));
    } on FingerprintException {
      return const Left(LoginFailed('Fingerprint canceled'));
    }
  }

  @override
  Future<Either<Failure, String>> checkTokenExpired(String key) async {
    try {
      final result = await loginRemoteDataSource.checkTokenExpired(key);
      return Right(result);
    } on UnauthenticatedException {
      return const Left(
          LoginFailed('Fingerprint failed, please login with email first'));
    } on ServerException {
      return const Left(ServerFailure('An error occurred while try to login'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

   @override
  Future<Either<Failure, void>> deleteCookie(String key) async {
    try {
      return Right(loginLocalDataSource.deleteCookie(key));
    } on LocalDatabaseException {
      return const Left(
          DatabaseFailure('An error occurred while try to delete cookie'));
    }
  }
}
