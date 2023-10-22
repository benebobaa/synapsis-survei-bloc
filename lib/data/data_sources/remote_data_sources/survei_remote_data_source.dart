// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:synapsis_survei/core/constants/api_urls.dart';
import 'package:synapsis_survei/core/error/exception.dart';
import 'package:synapsis_survei/data/models/all_survei_model.dart';
import 'package:synapsis_survei/data/models/detail_survei_model.dart';

abstract class SurveiRemoteDataSource {
  Future<AllSurveiModel> getAllSurvei();
  Future<DetailSurveiModel> getDetailSurvei(String idSurvei);
}

class SurveiRemoteDataSourceImpl extends SurveiRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  SurveiRemoteDataSourceImpl({
    required this.client,
    required this.sharedPreferences,
  });

  @override
  Future<AllSurveiModel> getAllSurvei() async {
    final response = await client.get(
      Uri.parse(ApiUrls.allSurvei),
      headers: {
        'Cookie': await Future.value(
          sharedPreferences.getString('cookie'),
        ),
      },
    );
    log('response ${response.body}');
    log('response ${response.headers}');
    if (response.statusCode == 200) {
      return AllSurveiModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      throw UnauthenticatedException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<DetailSurveiModel> getDetailSurvei(String idSurvei) async {
    final response = await client.get(
      Uri.parse(ApiUrls.detailSurveyById(idSurvei)),
      headers: {
        'Cookie': await Future.value(
          sharedPreferences.getString('cookie'),
        ),
      },
    );
    log('response detail survei ${response.body}');
    if (response.statusCode == 200) {
      return DetailSurveiModel.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      throw UnauthenticatedException();
    } else {
      throw ServerException();
    }
  }
}
