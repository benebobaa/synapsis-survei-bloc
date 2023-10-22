import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:synapsis_survei/core/constants/api_urls.dart';
import 'package:synapsis_survei/core/error/exception.dart';
import 'package:synapsis_survei/data/data_sources/remote_data_sources/login_remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:synapsis_survei/data/models/login_success_model.dart';

import '../../../helpers/constants/dummy_data_json.dart';
import '../../../helpers/json_reader.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  // late MockDio mockDio;
  late MockHttpClient mockHttpClient;
  late MockSharedPreferences mockSharedPreferences;
  late LoginRemoteDataSourceImpl loginRemoteDataSourceImpl;

  setUp(() {
    // mockDio = MockDio();
    mockHttpClient = MockHttpClient();
    mockSharedPreferences = MockSharedPreferences();
    loginRemoteDataSourceImpl = LoginRemoteDataSourceImpl(
        client: mockHttpClient, sharedPreferences: mockSharedPreferences);
  });

  const testEmail = 'budimanobsight@gmail.com';
  const testPassword = 'password';

  group('post login', () {
    test('should return [LoginSuccessModel] when the response code is 200',
        () async {
      //arrange
      when(
        mockHttpClient.post(
          Uri.parse(ApiUrls.login),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(readJson(DummyData.loginSuccessJson), 200),
      );

      //act
      final result =
          await loginRemoteDataSourceImpl.postLogin(testEmail, testPassword);

      //assert
      expect(result, isA<LoginSuccessModel>());
    });

    // test('should throw a [NotFoundException] when the response code is 404',
    //     () async {
    //   //arrange
    //   when(
    //     mockHttpClient.post(
    //       Uri.parse(ApiUrls.login),
    //       body: anyNamed('body'),
    //     ),
    //   ).thenAnswer(
    //     (_) async => http.Response('Email tidak ditemukan.', 404),
    //   );

    //   //act
    //   final result =
    //       loginRemoteDataSourceImpl.postLogin(testEmail, testPassword);

    //   //assert
    //   expect(result, throwsA(isA<NotFoundException>()));
    // });

    // test('should throw a [BadRequestException] when the response code is 400',
    //     () async {
    //   //arrange
    //   when(
    //     mockHttpClient.post(
    //       Uri.parse(ApiUrls.login),
    //       body: anyNamed('body'),
    //     ),
    //   ).thenAnswer(
    //     (_) async => http.Response('Password salah.', 400),
    //   );

    //   //act
    //   final result =
    //       loginRemoteDataSourceImpl.postLogin(testEmail, testPassword);

    //   //assert
    //   expect(result, throwsA(isA<BadRequestException>()));
    // });

    test(
        'should throw a [ServerException] when the response code is 500 or other',
        () async {
      //arrange
      when(
        mockHttpClient.post(
          Uri.parse(ApiUrls.login),
          body: anyNamed('body'),
        ),
      ).thenAnswer(
        (_) async => http.Response('Password salah.', 500),
      );

      //act
      final result =
          loginRemoteDataSourceImpl.postLogin(testEmail, testPassword);

      //assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
