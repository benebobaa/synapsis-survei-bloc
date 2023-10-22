// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:synapsis_survei/core/constants/api_urls.dart';
import 'package:synapsis_survei/core/error/exception.dart';
import 'package:synapsis_survei/data/models/all_survei_model.dart';
import 'package:synapsis_survei/data/models/login_success_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginSuccessModel> postLogin(String email, String password);
  Future<String> checkTokenExpired(String token);
}

class LoginRemoteDataSourceImpl extends LoginRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  LoginRemoteDataSourceImpl({
    required this.client,
    required this.sharedPreferences,
  });
  // final Dio dio;

  @override
  Future<LoginSuccessModel> postLogin(String email, String password) async {
    final response = await client.post(
      Uri.parse(ApiUrls.login),
      body: {
        'email': email,
        'password': password,
      },
    );
    log('response ${response.body}');
    log('response ${response.headers}');
    if (response.statusCode == 200) {
      sharedPreferences.setString(
          'cookie', response.headers['set-cookie'] ?? '');
      return LoginSuccessModel.fromJson(
        jsonDecode(response.body),
      );
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      throw BadRequestException(message: jsonDecode(response.body)['message']);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> checkTokenExpired(String token) async {
    final response = await client.get(
      Uri.parse(ApiUrls.allSurvei),
    );
    if (response.statusCode == 200) {
      return AllSurveiModel.fromJson(jsonDecode(response.body)).message;
    } else if (response.statusCode == 401) {
      throw UnauthenticatedException();
    } else {
      throw ServerException();
    }
  }
}
