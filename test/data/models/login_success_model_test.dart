import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:synapsis_survei/data/models/login_success_model.dart';
import 'package:synapsis_survei/domain/entities/login_success_entity.dart';

import '../../helpers/constants/dummy_data_json.dart';
import '../../helpers/json_reader.dart';

void main() {
  const testLoginSuccessModel = LoginSuccessModel(
    code: 200,
    status: true,
    message: 'success',
    data: DataLoginModel(occupationLevel: 3, occupationName: 'Relawan'),
  );

  test('should be a subclass of [LoginSuccessEntity]', () async {
    //arrange

    //act

    //assert
    expect(testLoginSuccessModel, isA<LoginSuccessEntity>());
  });

  test('should return a model from json', () async {
    //arrange
    final Map<String, dynamic> jsonMap =
        json.decode(readJson(DummyData.loginSuccessJson));

    //act
    final result = LoginSuccessModel.fromJson(jsonMap);

    //assert
    expect(result, testLoginSuccessModel);
  });

  test('should return a json map containing proper data', () async {
    //arrange

    //act
    final result = testLoginSuccessModel.toJson();

    //assert
    final expectedMap = {
      "code": 200,
      "status": true,
      "message": "success",
      "data": {"occupation_level": 3, "occupation_name": "Relawan"}
    };

    expect(result, expectedMap);
  });
}
