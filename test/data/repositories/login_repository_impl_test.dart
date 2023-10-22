import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:synapsis_survei/core/error/exception.dart';
import 'package:synapsis_survei/core/error/failure.dart';
import 'package:synapsis_survei/data/repositories/login_repository_impl.dart';

import '../../helpers/dummy_data/test_login_dummy.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockLoginRemoteDataSource mockLoginRemoteDataSource;
  late MockLoginLocalDataSource mockLoginLocalDataSource;
  late LoginRepositoryImpl loginRepositoryImpl;

  setUp(() {
    mockLoginRemoteDataSource = MockLoginRemoteDataSource();
    mockLoginLocalDataSource = MockLoginLocalDataSource();
    loginRepositoryImpl = LoginRepositoryImpl(
        loginRemoteDataSource: mockLoginRemoteDataSource,
        loginLocalDataSource: mockLoginLocalDataSource);
  });

  group('post login', () {
    test(
        'should return [LoginSuccessEntity] when call to data source is successful',
        () async {
      //arrange
      when(mockLoginRemoteDataSource.postLogin(testEmail, testPassword))
          .thenAnswer((_) async => testLoginSuccessModel);

      //act
      final result =
          await loginRepositoryImpl.postLogin(testEmail, testPassword);

      //assert
      expect(result, equals(const Right(testLoginSuccessEntity)));
    });
    test(
        'should return [ServerFailure] when a call to data source is unsuccessful',
        () async {
      //arrange
      when(mockLoginRemoteDataSource.postLogin(testEmail, testPassword))
          .thenThrow(ServerException());

      //act
      final result =
          await loginRepositoryImpl.postLogin(testEmail, testPassword);

      //assert
      expect(
          result,
          equals(const Left(
              ServerFailure('An error occurred while try to login'))));
    });

    test('should return [ConnectionFailure] when device has no internet',
        () async {
      //arrange
      when(mockLoginRemoteDataSource.postLogin(testEmail, testPassword))
          .thenThrow(const SocketException('Failed to connect to the network'));

      //act
      final result =
          await loginRepositoryImpl.postLogin(testEmail, testPassword);

      //assert
      expect(
          result,
          equals(const Left(
              ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
